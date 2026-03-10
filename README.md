# 🤖 GitHub Copilot CLI Demo

A hands-on demo showcasing the latest capabilities of **GitHub Copilot CLI** — your AI-powered pair programmer, right in the terminal.

---

## ✨ What Is GitHub Copilot CLI?

GitHub Copilot CLI brings the power of Copilot directly to your terminal. Chat with an AI assistant that understands your codebase, generates commands, explains complex scripts, fixes bugs, writes tests, and can even parallelize large tasks with the `/fleet` command — all without leaving your shell.

---

## 🚀 Quick Start

### Prerequisites

- [GitHub CLI](https://cli.github.com/) (`gh`) installed and authenticated
- A GitHub account with Copilot access (Free, Pro, or Enterprise)

### Install / Update Copilot CLI

```bash
# Install the Copilot CLI
gh extension install github/gh-copilot

# Or update to the latest version
gh extension upgrade gh-copilot

# Authenticate (if not already done)
gh auth login

# Launch the interactive interface
copilot
```

> **Tip:** Run `copilot help` to see all available commands, or type `/help` inside the interactive interface.

---

## 🎯 Key Commands at a Glance

| Command | What It Does |
|---|---|
| `gh copilot suggest "<task>"` | Translate natural language into a shell command |
| `gh copilot explain "<command>"` | Explain what a shell command does |
| `copilot` | Launch the full interactive AI assistant |
| `/fleet <prompt>` | Break a big task into parallel subtasks for speed |
| `/plan <prompt>` | Draft an implementation plan before coding |
| `/fix` | Identify and fix bugs or errors in your code |
| `/test` | Generate and run tests for your code |
| `/review` | Run a code review agent on your changes |
| `/delegate <prompt>` | Open a PR in a remote repo driven by AI |
| `/model` | Switch AI models (GPT-4o, Claude, Gemini, etc.) |
| `/diff` | Review all changes made in the current session |
| `/share` | Save or share the session as a Markdown file or gist |
| `/context` | Inspect context window token usage |
| `/compact` | Summarize conversation to reclaim context space |

---

## 📂 Demo Materials

| File | Purpose |
|---|---|
| [`DEMO_SCRIPT.md`](./DEMO_SCRIPT.md) | 📋 Full presenter walkthrough — follow this step by step |
| [`demo/buggy_app.js`](./demo/buggy_app.js) | 🐛 Intentionally buggy JavaScript app (great for `/fix`) |
| [`demo/calculator.py`](./demo/calculator.py) | 🐍 Python module ready for test generation (`/test`) |
| [`demo/deploy.sh`](./demo/deploy.sh) | 🚀 Complex deploy script for `gh copilot explain` |
| [`demo/meeting_transcripts/`](./demo/meeting_transcripts/) | 🗒️ Weekly meeting transcripts for analysis demos |
| [`demo/achievements.txt`](./demo/achievements.txt) | 📝 Raw quarterly achievements for performance review cleanup |
| [`demo/messy_files/`](./demo/messy_files/) | 📂 Poorly-named files for organization/rename demos |
| [`demo/AGENTS.md`](./demo/AGENTS.md) | ⚙️ Custom Copilot instructions for this project |

---

## 🔗 GitHub Activities from the CLI

Copilot CLI connects directly to GitHub.com, letting you manage your work without leaving the terminal:

- **Pull Requests** — List your open PRs, create new ones, review code changes, merge, or close
- **Issues** — Browse assigned issues, create new issues, find good first issues
- **Actions Workflows** — List, inspect, and create GitHub Actions workflows
- **Remote Repos** — Make file changes and raise PRs across repositories

> See the [GitHub Activities section of the demo script](./DEMO_SCRIPT.md#-section-8--github-activities-from-the-cli) for full examples and talking points.

---

## 🌟 Highlight: The `/fleet` Command

`/fleet` is Copilot CLI's most powerful new capability. It breaks a complex, multi-part task into **independent subtasks** and executes them **in parallel** using subagents, dramatically cutting completion time.

```
/fleet
Generate unit tests for all modules in demo/, run a code review on
deploy.sh for security issues, and update AGENTS.md to document
the project conventions.
```

Copilot acts as an orchestrator, spinning up subagents that each work in their own context window — perfect for large refactors, test suite generation, and cross-file changes.

---

## 📖 Resources

- [Official Copilot CLI Docs](https://docs.github.com/en/copilot/how-tos/copilot-cli)
- [CLI Command Reference](https://docs.github.com/en/copilot/reference/cli-command-reference)
- [Running tasks in parallel with `/fleet`](https://docs.github.com/en/copilot/concepts/agents/copilot-cli/fleet)
- [Autopilot Mode](https://docs.github.com/en/copilot/concepts/agents/copilot-cli/autopilot)
- [Creating Custom Agents](https://docs.github.com/en/copilot/how-tos/copilot-cli/customize-copilot/create-custom-agents-for-cli)

