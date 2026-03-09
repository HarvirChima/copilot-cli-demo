# 🎬 GitHub Copilot CLI — Demo Script

> **Presenter Guide**: This script walks you through a live, engaging demo of the latest GitHub Copilot CLI features. Each section is self-contained — feel free to mix and match sections based on your audience and time.
>
> ⏱ **Full demo**: ~30 minutes | **Quick demo**: Sections 1–4 (~15 minutes)

---

## 🛠️ Before You Start

### Setup Checklist

```bash
# 1. Verify Copilot CLI is ready
gh copilot --version

# 2. Clone the demo repo and navigate into it
git clone https://github.com/HarvirChima/copilot-cli-demo.git
cd copilot-cli-demo
```

> 💡 **Tip for presenters**: Run through the demo once before presenting. Have this file open in one terminal pane and the Copilot CLI in another.

---

## 📌 Section 1 — Getting Started with `gh copilot suggest`

**Talking point**: "Instead of Googling shell commands or checking man pages, you can describe what you want in plain English."

### Demo 1.1 — Basic command suggestion

```bash
gh copilot suggest "list all files modified in the last 7 days"
```

**Expected interaction**:
- Copilot suggests: `find . -type f -mtime -7`
- You'll see options: **Execute**, **Revise**, **Copy to clipboard**, **Rate response**
- Press `E` to execute or `R` to revise with follow-up

### Demo 1.2 — More complex suggestion

```bash
gh copilot suggest "find all JavaScript files larger than 100KB and show their sizes in human-readable format"
```

**Expected interaction**:
- Copilot suggests something like: `find . -name "*.js" -size +100k -exec ls -lh {} \;`
- Walk through the response options with the audience

### Demo 1.3 — DevOps-style suggestion

```bash
gh copilot suggest "show me Docker containers using the most memory, sorted from highest to lowest"
```

**Audience engagement**: Ask "What command would you normally use for this? How long would that take to look up?"

---

## 📌 Section 2 — Demystifying Commands with `gh copilot explain`

**Talking point**: "Ever seen a command that looks like black magic? Copilot can decode it instantly — great for code reviews and onboarding."

### Demo 2.1 — Explain a cryptic one-liner

```bash
gh copilot explain "find . -type f -name '*.log' -mtime +30 -exec rm -f {} \;"
```

**Copilot will explain**:
- `find .` — start from the current directory
- `-type f` — files only
- `-name '*.log'` — matching log files
- `-mtime +30` — not modified in 30+ days
- `-exec rm -f {}` — delete each one

### Demo 2.2 — Explain a complex git command

```bash
gh copilot explain "git log --oneline --graph --decorate --all"
```

### Demo 2.3 — Explain the deploy script in this repo

```bash
gh copilot explain "$(cat demo/deploy.sh)"
```

**Talking point**: "You can pipe file contents directly — Copilot reads and explains the whole script."

---

## 📌 Section 3 — Interactive Mode: Your AI Terminal Assistant

**Talking point**: "Now let's go deeper. The interactive mode is where Copilot CLI really shines — it has memory of your conversation and can make changes to your code."

### Launch interactive mode

```bash
copilot
```

> You'll see the Copilot banner and a prompt. Everything from here is typed inside the interactive interface.

### Demo 3.1 — Ask a contextual question

```
What does this repository do? Give me a quick summary.
```

### Demo 3.2 — Include a file in context

```
@demo/calculator.py

Explain what this module does and identify any edge cases that aren't handled.
```

> **Tip**: Use `@FILENAME` to include any file's content directly in the conversation context.

### Demo 3.3 — Fix a bug with `/fix`

```
@demo/buggy_app.js

There are several bugs in this file. Use /fix to identify and correct them all.
```

**Watch Copilot**:
- Analyze the code
- List each bug with an explanation
- Propose fixes
- Ask for your confirmation before applying changes

### Demo 3.4 — Generate tests

```
@demo/calculator.py

Generate comprehensive unit tests for all the functions in this file. Include edge cases and error handling tests.
```

> Copilot will create a new test file (`test_calculator.py`) with well-structured pytest tests.

### Demo 3.5 — Switch AI models

```
/model
```

- Browse available models: GPT-4o, Claude 3.5 Sonnet, Gemini 1.5 Pro, etc.
- Select a different model and ask the same question to compare outputs

---

## 📌 Section 4 — Plan Mode and the `/plan` Command

**Talking point**: "Before writing a single line of code, you can have Copilot draft a full implementation plan. This is great for complex features."

### Enable plan mode (Shift+Tab inside interactive mode)

```
Shift+Tab  (cycles: standard → plan → autopilot)
```

Or use the slash command directly:

```
/plan Add input validation to all functions in demo/calculator.py, 
      write unit tests for the new validation logic, 
      and update the module docstring to reflect the changes.
```

**Copilot will**:
1. Analyze the existing code
2. Draft a numbered implementation plan
3. Ask you to approve before proceeding

**Talking point**: "This is like pairing with a senior developer who shows you the full plan before touching anything."

---

## 📌 Section 5 — ⚡ The `/fleet` Command: Parallel AI Execution

**Talking point**: "This is the newest and most exciting feature. `/fleet` turns Copilot into an orchestrator — breaking your task into parallel subtasks handled by multiple AI subagents simultaneously."

### Demo 5.1 — Your first fleet task

```
/fleet
Review the code in demo/buggy_app.js for security vulnerabilities,
generate unit tests for demo/calculator.py covering all edge cases,
and create a CHANGELOG.md file summarizing all changes made in this session.
```

**Watch Copilot**:
- Analyze the prompt and identify 3 independent subtasks
- Spin up 3 subagents that work **in parallel**
- Show you progress as each subagent completes its work
- Present the combined results

### Demo 5.2 — Fleet with model specialization

```
/fleet
Use GPT-4o to write a technical architecture document for this project in ARCHITECTURE.md,
and use Claude to rewrite demo/deploy.sh with enhanced error handling and logging.
```

**Talking point**: "You can even direct fleet to use specific models for specific subtasks — use the model best suited for each type of work."

### Demo 5.3 — Fleet with autopilot (the power combo)

> First, draft a plan:

```
Shift+Tab  (switch to plan mode)
```

```
Refactor demo/calculator.py to add type hints, 
generate a full test suite with pytest,
and update demo/AGENTS.md with the new coding conventions used.
```

> Once the plan is ready, select: **"Accept plan and build on autopilot + /fleet"**

**Talking point**: "This is the ultimate workflow: plan → approve → let Copilot do the work in parallel, autonomously."

---

## 📌 Section 6 — Code Review with `/review`

**Talking point**: "Copilot can review your own changes before you push — like a built-in code reviewer."

### Make a change, then review it

```bash
# First, make a small change to a demo file (e.g., add a comment to calculator.py)
echo "# Added by demo" >> demo/calculator.py
```

Then inside interactive mode:

```
/review

Look at the recent changes in this repo and flag any potential issues, 
style violations, or improvements.
```

---

## 📌 Section 7 — Delegating to Remote Repos with `/delegate`

**Talking point**: "Copilot CLI can reach out beyond your local machine — delegating work to remote repos and creating pull requests on your behalf."

```
/delegate
In the HarvirChima/copilot-cli-demo repository, create a GitHub Actions 
workflow that automatically runs the Python tests on every pull request.
Open a PR with the changes.
```

**Copilot will**:
1. Create the workflow YAML
2. Open a pull request in the remote repository
3. Give you the PR link

---

## 📌 Section 8 — Productivity Tips & Customization

**Talking point**: "A few power-user tricks to get the most out of Copilot CLI."

### Custom instructions with `AGENTS.md`

```bash
# Show the demo AGENTS.md
cat demo/AGENTS.md
```

```
/init
```

> This creates `.copilot/` in your repo with project-specific instructions that Copilot reads automatically on startup.

### Session management

```
/share gist     # Share this session as a GitHub gist
/rename "bug-fix-session"   # Name the session for later reference
/resume         # Pick up a previous session
/context        # See how much of the context window you've used
/compact        # Summarize the conversation to free up context space
```

### Tool permissions for automation

```bash
# Allow all tools (great for automation/CI)
copilot --allow-all --prompt "Run the test suite and fix any failures"

# Fine-grained permissions
copilot --allow-tool 'shell(git:*)' --deny-tool 'shell(git push)'
```

---

## 🎉 Wrap-Up & Key Takeaways

1. **`gh copilot suggest`** — Turn plain English into shell commands
2. **`gh copilot explain`** — Decode any command or script
3. **Interactive mode** — A full AI coding assistant in your terminal
4. **`/plan`** — Draft and approve implementation plans
5. **`/fix` + `/test` + `/review`** — AI-powered code quality tools
6. **`/fleet`** — Parallel execution for large, multi-step tasks ⚡
7. **`/delegate`** — AI-generated PRs in remote repos

---

## 🔗 Resources

| Resource | Link |
|---|---|
| Official Docs | https://docs.github.com/en/copilot/how-tos/copilot-cli |
| CLI Command Reference | https://docs.github.com/en/copilot/reference/cli-command-reference |
| `/fleet` Deep Dive | https://docs.github.com/en/copilot/concepts/agents/copilot-cli/fleet |
| Autopilot Mode | https://docs.github.com/en/copilot/concepts/agents/copilot-cli/autopilot |
| Custom Agents | https://docs.github.com/en/copilot/how-tos/copilot-cli/customize-copilot/create-custom-agents-for-cli |
| Copilot CLI Features Page | https://github.com/features/copilot/cli/ |

---

> 💬 **Questions?** Try asking Copilot CLI itself: `gh copilot explain "how does /fleet work?"`
