# 🎬 GitHub Copilot CLI — Demo Script

> **Presenter Guide**: This script walks you through a live, engaging demo of the latest GitHub Copilot CLI features. Each section is self-contained — feel free to mix and match sections based on your audience and time.
>
> ⏱ **Full demo**: ~40 minutes | **Quick demo**: Sections 1–4 (~15 minutes) | **Non-engineering showcase**: Section 5 (~10 minutes)

---

## 🛠️ Before You Start

### Setup Checklist

```bash

# Clone the demo repo and navigate into it
git clone https://github.com/HarvirChima/copilot-cli-demo.git
cd copilot-cli-demo

# Spin up the CLI and show the login flow
copilot
/login
```

> 💡 **Tip for presenters**: Run through the demo once before presenting. Have this file open in one terminal pane and the Copilot CLI in another.

---

## 📌 Section 1 — Getting Started with basic commands

**Talking point**: "Instead of Googling shell commands or checking man pages, you can describe what you want in plain English."

### Demo 1.1 — Basic command suggestion

```bash
list all files modified in the last 7 days
```

**Expected interaction**:
- Copilot suggests: `find . -type f -mtime -7`
- You'll see options: **Execute**, **Revise**, **Copy to clipboard**, **Rate response**
- Press `E` to execute or `R` to revise with follow-up

### Demo 1.2 — More complex suggestion

```bash
find all JavaScript files larger than 100KB and show their sizes in human-readable format
```

**Expected interaction**:
- Copilot suggests something like: `find . -name "*.js" -size +100k -exec ls -lh {} \;`
- Walk through the response options with the audience

### Demo 1.3 — DevOps-style suggestion

```bash
show me Docker containers using the most memory, sorted from highest to lowest
```

**Audience engagement**: Ask "What command would you normally use for this? How long would that take to look up?"

---

## 📌 Section 2 — Demystifying Commands

**Talking point**: "Ever seen a command that looks like black magic? Copilot can decode it instantly — great for code reviews and onboarding."

### Demo 2.1 — Explain a cryptic one-liner

```bash
explain "find . -type f -name '*.log' -mtime +30 -exec rm -f {} \;"
```

**Copilot will explain**:
- `find .` — start from the current directory
- `-type f` — files only
- `-name '*.log'` — matching log files
- `-mtime +30` — not modified in 30+ days
- `-exec rm -f {}` — delete each one

### Demo 2.2 — Explain a complex git command

```bash
explain "git log --oneline --graph --decorate --all"
```

### Demo 2.3 — Explain the deploy script in this repo

```bash
explain "$(cat demo/deploy.sh)"
```

**Talking point**: "You can pipe file contents directly — Copilot reads and explains the whole script."

---

## 📌 Section 3 — GitHub Activities from the CLI

**Talking point**: "Copilot CLI isn't just about local work — it connects directly to GitHub.com. You can manage pull requests, triage issues, explore Actions workflows, and more, all without leaving your terminal."

### Demo 3.1 — Fetch details about your work on GitHub

```
List my open PRs
```

**Copilot will**:
- Query GitHub.com for your open pull requests across repositories
- Display a summary with titles, repos, and status

> **Tip**: For more specific results, include the repository name: `List all open issues assigned to me in OWNER/REPO`

### Demo 3.2 — Start working on an issue

```
I've been assigned this issue: https://github.com/HarvirChima/copilot-cli-demo/issues/1234. Start working on this for me in a suitably named branch.
```

**Copilot will**:
- Read the issue details from GitHub
- Create a descriptively named branch
- Begin implementing the fix or feature described in the issue

### Demo 3.3 — Make changes and raise a pull request

```
In the root of this repo, add a Node script called user-info.js that outputs
information about the user who ran the script. Create a pull request to add
this file to the repo on GitHub.
```

**Copilot will**:
- Write the code
- Create a pull request on GitHub.com on your behalf — **you** are marked as the PR author

Another example — editing a remote repo:

```
Create a PR that updates the README at https://github.com/HarvirChima/copilot-cli-demo,
changing the subheading "How to run" to "Example usage"
```

### Demo 3.4 — Create an issue on GitHub

```
Raise an improvement issue in HarvirChima/copilot-cli-demo. In src/someapp/somefile.py
the `file = open('data.txt', 'r')` block opens a file but never closes it.
```

**Copilot will**:
- Open a new issue in the specified repository with a clear title and description

### Demo 3.5 — Review code changes in a pull request

```
Check the changes made in PR https://github.com/HarvirChima/copilot-cli-demo/pull/57575.
Report any serious errors you find in these changes.
```

**Copilot will**:
- Fetch the PR diff from GitHub
- Analyze the changes for bugs, security issues, and logic errors
- Report a summary of problems directly in the CLI

### Demo 3.6 — Manage pull requests

```
Merge all of the open PRs that I've created in HarvirChima/copilot-cli-demo
```

```
Close PR #11 on HarvirChima/copilot-cli-demo
```

**Talking point**: "You can merge, close, or update PRs without switching to a browser — perfect for batch operations."

### Demo 3.7 — Find specific issues or workflows

```
Use the GitHub MCP server to find good first issues for a new team member
to work on from HarvirChima/copilot-cli-demo
```

> **Note**: If you know that a specific MCP server can achieve a particular task, specifying it in your prompt helps Copilot deliver the results you want.

```
List any Actions workflows in this repo that add comments to PRs
```

### Demo 3.8 — Create a GitHub Actions workflow

```
Branch off from main and create a GitHub Actions workflow that will run on
pull requests, or can be run manually. The workflow should run eslint to
check for problems in the changes made in the PR. If warnings or errors are
found these should be shown as messages in the diff view of the PR. I want
to prevent code with errors from being merged into main so, if any errors
are found, the workflow should cause the PR check to fail. Push the new
branch and create a pull request.
```

**Copilot will**:
1. Create a new branch from `main`
2. Generate a complete GitHub Actions workflow YAML
3. Push the branch and open a pull request — all from the CLI

**Talking point**: "From triaging issues to creating full CI/CD workflows, Copilot bridges your terminal and GitHub.com seamlessly."

---

## 📌 Section 4 — Productivity Tips & Customization

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

## 📌 Section 5 — Non-Engineering Use Cases

**Talking point**: "Copilot CLI isn't just for developers. It's an AI assistant that can handle everyday workplace tasks — analyzing meetings, cleaning up documents, organizing files. Let's look at a few examples."

### Demo 5.1 — Analyze meeting transcripts

```
@demo/meeting_transcripts/standup-2025-03-03.txt
@demo/meeting_transcripts/product-review-2025-03-05.txt
@demo/meeting_transcripts/retro-2025-03-07.txt
@demo/meeting_transcripts/client-call-2025-03-06.txt

Analyze these meeting transcripts from this week. For each meeting, extract:
- Key decisions made
- Action items (with owners and deadlines)
- Open blockers or risks

Then give me a consolidated summary of all action items across every meeting, sorted by owner.
```

**Watch Copilot**:
- Read through all four transcripts
- Extract structured information from unstructured conversations
- Cross-reference recurring themes (e.g., the bulk export feature appears in multiple meetings)
- Produce a single organized summary

**Talking point**: "Imagine doing this every Friday with your week's meetings — a five-minute prompt replaces an hour of manual note-taking."

### Demo 5.2 — Clean up achievements for a performance review

```
@demo/achievements.txt

These are my raw quarterly achievements. Clean them up for a formal performance review by:
1. Rewriting each item with stronger action verbs and quantified impact
2. Grouping them into categories (e.g., Leadership, Delivery, Customer Impact, Process Improvement)
3. Highlighting the top 5 most impactful achievements
4. Suggesting any gaps I should address (e.g., missing themes like technical growth or mentorship outcomes)
```

**Watch Copilot**:
- Transform casual notes into professional, review-ready bullet points
- Add structure and categorization
- Identify the strongest achievements and surface gaps

**Talking point**: "Performance review season is painful for everyone. Copilot can turn a brain dump into polished, well-organized talking points in seconds."

### Demo 5.3 — Organize a messy folder of files

```
Look at the files in demo/messy_files/ and:
1. Read each file to understand its content
2. Suggest a clear, descriptive filename for each one based on what it actually contains
3. Create a shell script that renames all the files to their new names
```

**Watch Copilot**:
- Inspect each file's contents
- Generate meaningful names like `q1-budget-summary.txt`, `product-launch-checklist.txt`, etc.
- Produce a ready-to-run rename script

**Talking point**: "We all have that one folder — or shared drive — full of 'Untitled document' and 'Copy of Copy of deck'. Copilot can make sense of it for you."

### Demo 5.4 — Fleet: parallel non-engineering tasks

```
/fleet
Analyze the meeting transcripts in demo/meeting_transcripts/ and create a one-page
executive summary of the week's key decisions and risks,
clean up the achievements in demo/achievements.txt into a polished performance review format,
and rename the files in demo/messy_files/ with descriptive names based on their content.
```

**Talking point**: "And of course, with `/fleet` you can do all three of these in parallel — just like a team of assistants working at the same time."

---

## 📌 Section 6 — Interactive Mode: Your AI Terminal Assistant

**Talking point**: "Now let's go deeper. The interactive mode is where Copilot CLI really shines — it has memory of your conversation and can make changes to your code."

### Demo 6.1 — Ask a contextual question

```
What does this repository do? Give me a quick summary.
```

### Demo 6.2 — Include a file in context

```
@demo/calculator.py

Explain what this module does and identify any edge cases that aren't handled.
```

> **Tip**: Use `@FILENAME` to include any file's content directly in the conversation context.

### Demo 6.3 — Fix a bug with `/fix`

```
@demo/buggy_app.js

There are several bugs in this file. Use /fix to identify and correct them all.
```

**Watch Copilot**:
- Analyze the code
- List each bug with an explanation
- Propose fixes
- Ask for your confirmation before applying changes

### Demo 6.4 — Generate tests

```
@demo/calculator.py

Generate comprehensive unit tests for all the functions in this file. Include edge cases and error handling tests.
```

> Copilot will create a new test file (`test_calculator.py`) with well-structured pytest tests.

### Demo 6.5 — Switch AI models

```
/model
```

- Browse available models: GPT-4o, Claude 3.5 Sonnet, Gemini 1.5 Pro, etc.
- Select a different model and ask the same question to compare outputs

---

## 📌 Section 7 — Plan Mode and the `/plan` Command

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

## 📌 Section 8 — ⚡ The `/fleet` Command: Parallel AI Execution

**Talking point**: "This is the newest and most exciting feature. `/fleet` turns Copilot into an orchestrator — breaking your task into parallel subtasks handled by multiple AI subagents simultaneously."

### Demo 8.1 — Your first fleet task

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

### Demo 8.2 — Fleet with model specialization

```
/fleet
Use GPT-4o to write a technical architecture document for this project in ARCHITECTURE.md,
and use Claude to rewrite demo/deploy.sh with enhanced error handling and logging.
```

**Talking point**: "You can even direct fleet to use specific models for specific subtasks — use the model best suited for each type of work."

### Demo 8.3 — Fleet with autopilot (the power combo)

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

## 📌 Section 9 — Code Review with `/review`

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

## 📌 Section 10 — Delegating to Remote Repos with `/delegate`

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

## 🎉 Wrap-Up & Key Takeaways

1. **`gh copilot suggest`** — Turn plain English into shell commands
2. **`gh copilot explain`** — Decode any command or script
3. **GitHub Activities** — Manage PRs, issues, and Actions workflows from the CLI
4. **Productivity Tips** — Custom instructions, session management, and tool permissions
5. **Non-engineering tasks** — Meeting analysis, document cleanup, file organization, and more
6. **Interactive mode** — A full AI coding assistant in your terminal
7. **`/plan`** — Draft and approve implementation plans
8. **`/fleet`** — Parallel execution for large, multi-step tasks ⚡
9. **`/fix` + `/test` + `/review`** — AI-powered code quality tools
10. **`/delegate`** — AI-generated PRs in remote repos

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
