# Project Understanding — Review Log

## Review 001 — Static review and resource-inventory refinement

- **Date:** 2026-11-22
- **Reviewed component:** `skills/project-understanding/SKILL.md`
- **Review basis:** `SKILL-ARCHITECTURE.md`, `evals/project-understanding/cases.md`, `scorecard.md`, and repository guidance in `AGENTS.md`.
- **Review type:** Static design review; not an external AI-agent behavioral run.

### Finding

The Skill already instructed agents to inspect accessible context, distinguish confirmed/inferred/unknown/conflicting information, ask focused questions, and avoid claiming access they did not have. However, its resource-inspection step did not explicitly require agents to classify repository documentation separately from the target Motion Graphics project, rendered preview, references, and development/tooling files.

This distinction is important for PU-05: a repository can be available while the actual edit being requested for review is absent.

### Change made

Updated `skills/project-understanding/SKILL.md` to add an **Inventory and classify available resources** subsection. It now asks agents to:

- Inspect relevant accessible sources before requesting re-uploads or repeated information.
- Classify target projects, rendered previews, reference material, project documentation, and development/tooling files separately.
- Record whether relevant resources were inspected, merely identified, present but not inspected, not found in checked sources, or inaccessible.
- Avoid describing a workspace as empty when repository/documentation files exist but the target edit is absent.
- Request the smallest useful missing input: usually a rendered preview or screenshot for initial visual review, and a native project file when editable structure or direct modification is needed.

The Project Understanding Brief's references/assets field was updated to carry this classification forward during handoff.

### Validation performed

- `python tests/validate_skills.py` — **PASS** (1 Skill checked).

### Not yet tested

- PU-01 through PU-05 have not yet been run against an external AI-agent client with this Skill loaded.
- No Alight Motion or After Effects execution was performed.
- No multi-agent handoff or runtime tool integration was tested.

### Next action

Run PU-01 through PU-05 in a compatible Agent Skills client, score each response using `scorecard.md`, and record the client/model, Skill revision, date, evidence, and critical failures. Revise the Skill only where the behavioral tests demonstrate a gap.

## Review 002 — PU-05 inventory helper and repository consistency

- **Date:** 2026-11-21
- **Reviewed package:** `motion-graphics-ai-framework-v0.3.2-wip.zip`
- **Review type:** Static repository review plus local script tests.

### Findings

1. The extension-count helper correctly normalized suffixes and handled the reviewed edge cases, but a missing argument or missing archive returned exit status `0` because the original pipeline did not enable `pipefail` or validate its input. This could make a failed inventory look successful.
2. The root README and `AGENTS.md` repository trees did not list the already-present `evals/project-understanding/scripts/` and `results/PU-05/` resources.
3. The evaluation README still described the pack as not yet run externally, despite the presence of a PU-05 observation record.
4. The handoff note omitted the newly added PU-05 result and inventory helper from its file inventory.

### Changes made in this review

- Hardened `count-extensions.sh` with strict argument validation, readable-file validation, `unzip` availability checking, and `set -euo pipefail` so upstream ZIP/listing errors propagate.
- Added `tests/test_count_extensions.sh` covering stdin and ZIP input, directories, dotted directory names, dotfiles, uppercase suffixes, compound suffixes, no-extension names, trailing dots, and failure exit statuses.
- Updated README and AGENTS repository trees and documented the new test command.
- Clarified that PU-05 has an observation record but is not independently scored, and that formal reports for PU-01 through PU-04 remain outstanding.
- Updated the project handoff inventory and next steps.

### Validation performed

- `bash tests/test_count_extensions.sh` — PASS.
- `python tests/validate_skills.py` — **PASS** (1 Skill checked).
- `bash tests/test_count_extensions.sh` — **PASS** (stdin cases, generated ZIP cases, missing argument/archive, and corrupt archive).
- Markdown relative links — **PASS** (12 Markdown files checked).
- Manual failure-path checks — missing archive returned 66; missing argument returned 64.
- Extension helper against the supplied v0.3.2 WIP archive — 24 entries, 9 directories, 15 files; `.md` 12, `.py` 1, `.sh` 1, `.txt` 1.

### Remaining limitations

- `PU-05` is an observation record and remains `Not scored` pending an independent scorecard review.
- Formal result reports for PU-01 through PU-04 are not included in this package.
- This review does not establish multi-agent compatibility or real Alight Motion / After Effects execution.
