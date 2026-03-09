# AGENTS.md — Copilot CLI Custom Instructions for copilot-cli-demo

> This file provides project-level context and coding conventions to GitHub Copilot CLI.
> Copilot reads this automatically when you run `copilot` or `/init` from this directory.
> For more information see: https://docs.github.com/en/copilot/how-tos/copilot-cli

---

## Project Purpose

This is a **demo repository** for showcasing GitHub Copilot CLI capabilities.
The goal is to provide realistic sample code that lets presenters demonstrate
features like `/fix`, `/test`, `/explain`, `/fleet`, and `/plan`.

---

## Repository Structure

```
copilot-cli-demo/
├── README.md           # Project overview and quick-start guide
├── DEMO_SCRIPT.md      # Presenter walkthrough script
└── demo/
    ├── AGENTS.md       # This file — Copilot custom instructions
    ├── buggy_app.js    # Intentionally buggy JavaScript (for /fix demos)
    ├── calculator.py   # Python module (for /test and /explain demos)
    └── deploy.sh       # Bash deployment script (for explain demos)
```

---

## Coding Conventions

### JavaScript
- Use `const` and `let` (never `var`)
- Use strict equality (`===`) everywhere
- Validate all function inputs; throw descriptive errors
- Use `Array.filter()` / `Array.map()` instead of `forEach` + mutation
- Follow camelCase naming

### Python
- Follow PEP 8 style
- Add type hints to all function signatures
- Write Google-style docstrings with Args, Returns, and Raises
- Use `pytest` for all tests; group tests by function in classes
- Raise `ValueError` for invalid inputs

### Bash
- Use `set -euo pipefail` at the top of every script
- Prefer `[[ ]]` over `[ ]` for conditionals
- Quote all variables: `"${VAR}"` not `$VAR`
- Add color-coded log functions: `log`, `success`, `warn`, `error`

---

## Test Conventions

- Python tests live in files named `test_<module>.py`
- Each test function name should start with `test_` and describe what it tests
- Include at least one happy-path, one edge-case, and one error-path test per function

---

## Demo Notes

- When fixing bugs in `buggy_app.js`, explain each bug before applying the fix
- When generating tests for `calculator.py`, produce a full `test_calculator.py` file
- When explaining `deploy.sh`, break the explanation down section by section
