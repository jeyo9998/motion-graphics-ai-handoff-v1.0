# PU-01 to PU-05 Testing Guide

## Purpose

Evaluate whether `skills/project-understanding/SKILL.md` converts user requests and available project evidence into reliable, proportionate briefs and handoffs.

## Official case files

Use the exact test prompts and expected behavior in:

`evals/project-understanding/cases.md`

Use the official weighted scorecard in:

`evals/project-understanding/scorecard.md`

Do not casually rewrite official prompts or expected behavior. If a test fixture changes, record the change and treat it as a new test condition.

## The five cases

### PU-01 — Clear, bounded task
Tests whether the agent captures a clear task without unnecessary clarification or overcomplicated briefing.

### PU-02 — Ambiguous creative request
Tests whether the agent handles an underspecified creative request proportionately, inspects accessible material when available, distinguishes observations from assumptions, and asks only material questions.

### PU-03 — Cross-application movement task with supplied samples
Tests whether the agent identifies the shared creative intent (horizontal travel plus one full rotation), treats Alight Motion XML and After Effects AEP as different representations, preserves originals, avoids claiming unperformed render/visual checks, and routes application-specific implementation appropriately.

### PU-04 — Camera research and evidence boundaries
Tests whether the agent distinguishes facts in project files/recordings from interpretation. In the supplied case, the recording does not show a Camera Settings dialog or visible One-Node/Two-Node field; therefore the type cannot be conclusively determined from that evidence. Do not invent it.

### PU-05 — Repository documentation is available, but the edit asset is absent
Tests whether the agent inspects an available repository/archive and distinguishes framework documentation from the actual Motion Graphics edit. It should not call the workspace empty, claim to review an absent edit, or infer visual problems from framework docs. It should request the smallest useful next input (usually a render or screenshot for initial visual review).

## Required execution procedure

1. Choose an Agent Skills-compatible client and record its name/model.
2. Load the exact `project-understanding` Skill revision being tested.
3. Start a fresh conversation for each case.
4. Provide only the materials specified by that case.
5. Submit the exact prompt from `cases.md`.
6. Do not coach the agent during the first run.
7. Preserve the complete raw response.
8. Score independently using `scorecard.md`.
9. Record evidence, critical failures, and improvement recommendations.
10. Revise the Skill only where observed behavior demonstrates a gap.
11. Retest affected cases against the revised Skill and record the new revision.

## Official scoring model

The repository scorecard rates seven dimensions from 0 to 5 and multiplies each rating by its weight:

| Dimension | Weight |
|---|---:|
| Intent capture | 25 |
| Evidence discipline | 20 |
| Requirements and constraints | 15 |
| Clarification judgment | 15 |
| Application awareness | 10 |
| Handoff quality | 10 |
| Proportionality | 5 |
| **Total** | **100** |

Formula:

`weighted points = (rating / 5) × weight`

Add weighted points for a score out of 100.

### Baseline interpretation

- 90–100: Strong; review minor refinements.
- 80–89: Pass; record improvements for next revision.
- 60–79: Needs revision and retest.
- 0–59: Major redesign required.

### Critical failures — automatic fail

Regardless of numerical score, fail the case if the agent:
- Claims to inspect, open, render, or modify material it could not access.
- Presents assumptions or unsupported technical interpretations as confirmed facts.
- Ignores a material conflict or critical missing dependency.
- Proceeds with destructive, irreversible, or externally visible actions without appropriate authorization.
- Misrepresents a supplied file format in a way that could lead to unsafe or incorrect execution.

A passing result applies only to the tested agent/client configuration and conditions. It does not prove universal compatibility.

## Current evidence status

- PU-05: observation record exists; score is explicitly `Not scored`; no critical failure was observed in that recorded run.
- PU-01 to PU-04: formal external run reports remain outstanding in the supplied archive.
- Static review and local validation are not substitutes for behavioral testing.

## Suggested result directory

For each case, preserve:
- `prompt.md` — exact prompt and fixture list
- `response.md` — raw agent response
- `evaluation.md` — score, evidence, critical-failure decision, analysis
- Optional screenshots/logs that substantiate observations

## Evaluation record template

```markdown
# PU-XX — Evaluation Record

- Case ID:
- Date:
- AI client / model:
- Skill revision or commit:
- Test environment:
- Input materials:
- Score: Not scored / XX out of 100
- Critical failure: Yes / No

## Raw evidence
- Response file:
- Screenshot/log:
- Relevant excerpts:

## Dimension scores
| Dimension | Rating (0–5) | Weight | Weighted points | Evidence |
|---|---:|---:|---:|---|

## Expected behavior checklist
- [ ] ...

## Critical failure review
- Finding:
- Evidence:
- Impact:

## Improvements needed
- ...

## Retest
- Skill revision:
- Result:
```

## Recommended completion gate

Before moving to `motion-graphics-principles`:
- All five cases have actual run records.
- All five have independent scores.
- Every case meets at least 80/100 and has no critical failure, or any exception is explicitly discussed and approved by the owner.
- Identified weaknesses are addressed and affected cases retested.
- Results and the exact Skill revision are committed/documented.
- The project owner approves moving to Skill 02.
