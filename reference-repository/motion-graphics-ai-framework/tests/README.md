# Local Validation

This folder contains repository checks that can be run locally.

## Requirements

- Python 3.10 or newer
- Dependencies listed in `requirements-dev.txt`

## Run

From the repository root:

```bash
python -m pip install -r requirements-dev.txt
python tests/validate_skills.py
bash tests/test_count_extensions.sh
```

On systems where `python` refers to Python 2 or is unavailable, use `python3` instead. On Windows, `py` can be used in place of `python`.

## What the validator checks

- Every immediate directory under `skills/` contains `SKILL.md`.
- YAML frontmatter parses correctly.
- `name` and `description` are non-empty strings.
- The skill name follows the lowercase kebab-case rule and matches its directory name.
- The name and description do not exceed the validator's configured limits.
- `SKILL.md` remains below the configured 500-line limit.

A successful run validates basic repository structure only. It does not prove that an AI agent will discover, activate, or correctly follow a skill, and it does not test application execution in Alight Motion or After Effects.

## Extension inventory helper tests

`test_count_extensions.sh` checks the ZIP extension counter with synthetic entry names and a generated ZIP archive. It also verifies that a missing argument and a missing archive produce non-zero exit statuses. The helper requires Bash, `awk`, `sort`, and `unzip` for ZIP input; the regression test also uses Python's standard-library `zipfile`.
