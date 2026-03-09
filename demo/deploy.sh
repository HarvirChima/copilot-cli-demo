#!/usr/bin/env bash
# =============================================================================
# deploy.sh — Application Deployment Script
#
# Usage: ./deploy.sh [--env <environment>] [--tag <git-tag>] [--dry-run]
#
# USE THIS FILE DURING THE DEMO:
#   gh copilot explain "$(cat demo/deploy.sh)"
#   or inside interactive mode: @demo/deploy.sh  then ask Copilot to explain it
#
# This script demonstrates a realistic deployment workflow with:
#   - Argument parsing
#   - Environment validation
#   - Health checks
#   - Rollback on failure
#   - Slack notifications
# =============================================================================

set -euo pipefail
IFS=$'\n\t'

# ---------------------------------------------------------------------------
# Defaults
# ---------------------------------------------------------------------------
ENVIRONMENT="staging"
GIT_TAG=""
DRY_RUN=false
APP_NAME="copilot-demo-app"
DEPLOY_DIR="/opt/${APP_NAME}"
LOG_FILE="/var/log/${APP_NAME}/deploy.log"
SLACK_WEBHOOK_URL="${SLACK_WEBHOOK_URL:-}"
HEALTH_CHECK_URL="https://${ENVIRONMENT}.example.com/health"
HEALTH_CHECK_RETRIES=5
HEALTH_CHECK_INTERVAL=10  # seconds

# ---------------------------------------------------------------------------
# Color helpers
# ---------------------------------------------------------------------------
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

log()     { echo -e "${BLUE}[INFO]${NC}  $(date '+%Y-%m-%d %H:%M:%S') $*" | tee -a "${LOG_FILE}"; }
success() { echo -e "${GREEN}[OK]${NC}    $(date '+%Y-%m-%d %H:%M:%S') $*" | tee -a "${LOG_FILE}"; }
warn()    { echo -e "${YELLOW}[WARN]${NC}  $(date '+%Y-%m-%d %H:%M:%S') $*" | tee -a "${LOG_FILE}"; }
error()   { echo -e "${RED}[ERROR]${NC} $(date '+%Y-%m-%d %H:%M:%S') $*" | tee -a "${LOG_FILE}" >&2; }

# ---------------------------------------------------------------------------
# Argument parsing
# ---------------------------------------------------------------------------
parse_args() {
  while [[ $# -gt 0 ]]; do
    case $1 in
      --env)      ENVIRONMENT="$2"; shift 2 ;;
      --tag)      GIT_TAG="$2";     shift 2 ;;
      --dry-run)  DRY_RUN=true;     shift   ;;
      -h|--help)  usage;             exit 0  ;;
      *)          error "Unknown argument: $1"; usage; exit 1 ;;
    esac
  done
}

usage() {
  echo "Usage: $0 [--env staging|production] [--tag <git-tag>] [--dry-run]"
}

# ---------------------------------------------------------------------------
# Pre-flight checks
# ---------------------------------------------------------------------------
preflight_checks() {
  log "Running pre-flight checks..."

  # Validate environment
  if [[ ! "${ENVIRONMENT}" =~ ^(staging|production)$ ]]; then
    error "Invalid environment '${ENVIRONMENT}'. Must be 'staging' or 'production'."
    exit 1
  fi

  # Require explicit tag for production
  if [[ "${ENVIRONMENT}" == "production" && -z "${GIT_TAG}" ]]; then
    error "A --tag is required for production deployments."
    exit 1
  fi

  # Confirm production deploy
  if [[ "${ENVIRONMENT}" == "production" && "${DRY_RUN}" == "false" ]]; then
    warn "You are about to deploy to PRODUCTION. Type 'yes' to confirm:"
    read -r confirmation
    if [[ "${confirmation}" != "yes" ]]; then
      log "Deployment cancelled by user."
      exit 0
    fi
  fi

  # Ensure required tools are available
  for tool in git docker curl jq; do
    if ! command -v "${tool}" &>/dev/null; then
      error "Required tool not found: ${tool}"
      exit 1
    fi
  done

  success "Pre-flight checks passed."
}

# ---------------------------------------------------------------------------
# Build
# ---------------------------------------------------------------------------
build_image() {
  local tag="${GIT_TAG:-$(git rev-parse --short HEAD)}"
  local image="${APP_NAME}:${tag}"

  log "Building Docker image: ${image}"

  if [[ "${DRY_RUN}" == "true" ]]; then
    log "[DRY RUN] Would run: docker build -t ${image} ."
    return 0
  fi

  docker build \
    --build-arg BUILD_DATE="$(date -u +'%Y-%m-%dT%H:%M:%SZ')" \
    --build-arg GIT_SHA="${tag}" \
    -t "${image}" \
    . 2>&1 | tee -a "${LOG_FILE}"

  success "Image built: ${image}"
  echo "${image}"
}

# ---------------------------------------------------------------------------
# Deploy
# ---------------------------------------------------------------------------
deploy() {
  local image="$1"

  log "Deploying ${image} to ${ENVIRONMENT}..."

  if [[ "${DRY_RUN}" == "true" ]]; then
    log "[DRY RUN] Would deploy ${image} to ${ENVIRONMENT}"
    return 0
  fi

  # Save current version for potential rollback
  local previous_image
  previous_image=$(docker inspect "${APP_NAME}" --format='{{.Config.Image}}' 2>/dev/null || echo "none")

  # Stop existing container
  docker stop "${APP_NAME}" 2>/dev/null && docker rm "${APP_NAME}" 2>/dev/null || true

  # Start new container
  docker run \
    --detach \
    --name "${APP_NAME}" \
    --restart unless-stopped \
    --env "APP_ENV=${ENVIRONMENT}" \
    --publish 8080:8080 \
    "${image}" || {
      error "Failed to start container. Initiating rollback to ${previous_image}..."
      rollback "${previous_image}"
      exit 1
    }

  success "Container started: ${APP_NAME}"
  echo "${previous_image}"
}

# ---------------------------------------------------------------------------
# Health check
# ---------------------------------------------------------------------------
health_check() {
  log "Running health check at ${HEALTH_CHECK_URL}..."

  local attempt=1
  while [[ ${attempt} -le ${HEALTH_CHECK_RETRIES} ]]; do
    if curl --silent --fail --max-time 5 "${HEALTH_CHECK_URL}" | jq -e '.status == "ok"' &>/dev/null; then
      success "Health check passed (attempt ${attempt}/${HEALTH_CHECK_RETRIES})."
      return 0
    fi
    warn "Health check failed (attempt ${attempt}/${HEALTH_CHECK_RETRIES}). Retrying in ${HEALTH_CHECK_INTERVAL}s..."
    sleep "${HEALTH_CHECK_INTERVAL}"
    (( attempt++ ))
  done

  error "Health check failed after ${HEALTH_CHECK_RETRIES} attempts."
  return 1
}

# ---------------------------------------------------------------------------
# Rollback
# ---------------------------------------------------------------------------
rollback() {
  local previous_image="$1"

  if [[ "${previous_image}" == "none" || -z "${previous_image}" ]]; then
    error "No previous version to roll back to."
    return 1
  fi

  warn "Rolling back to ${previous_image}..."

  docker stop "${APP_NAME}" 2>/dev/null && docker rm "${APP_NAME}" 2>/dev/null || true

  docker run \
    --detach \
    --name "${APP_NAME}" \
    --restart unless-stopped \
    --env "APP_ENV=${ENVIRONMENT}" \
    --publish 8080:8080 \
    "${previous_image}"

  success "Rollback complete. Running: ${previous_image}"
}

# ---------------------------------------------------------------------------
# Notify
# ---------------------------------------------------------------------------
notify_slack() {
  local status="$1"
  local message="$2"

  if [[ -z "${SLACK_WEBHOOK_URL}" ]]; then
    log "SLACK_WEBHOOK_URL not set — skipping Slack notification."
    return 0
  fi

  local emoji
  emoji=$( [[ "${status}" == "success" ]] && echo ":white_check_mark:" || echo ":red_circle:" )

  curl --silent --fail -X POST "${SLACK_WEBHOOK_URL}" \
    -H 'Content-type: application/json' \
    --data "$(jq -n \
      --arg text "${emoji} *${APP_NAME}* deployment to *${ENVIRONMENT}*: ${message}" \
      '{text: $text}')" || warn "Slack notification failed."
}

# ---------------------------------------------------------------------------
# Main
# ---------------------------------------------------------------------------
main() {
  parse_args "$@"

  log "=========================================="
  log "  ${APP_NAME} Deployment"
  log "  Environment : ${ENVIRONMENT}"
  log "  Git Tag     : ${GIT_TAG:-<HEAD>}"
  log "  Dry Run     : ${DRY_RUN}"
  log "=========================================="

  mkdir -p "$(dirname "${LOG_FILE}")"

  preflight_checks

  local image
  image=$(build_image)

  local previous_image
  previous_image=$(deploy "${image}")

  if ! health_check; then
    error "Deployment failed health check. Rolling back..."
    rollback "${previous_image}"
    notify_slack "failure" "Deployment of \`${image}\` FAILED — rolled back to \`${previous_image}\`."
    exit 1
  fi

  notify_slack "success" "Successfully deployed \`${image}\` 🚀"
  success "Deployment complete: ${image} is live on ${ENVIRONMENT}."
}

main "$@"
