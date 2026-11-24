# Project Understanding — Evaluation Pack

**Status:** Initial evaluation pack with partial external-run evidence. PU-05 has a documented observation record; formal independent scoring and archived reports for PU-01 through PU-04 remain outstanding.

This pack tests whether `skills/project-understanding/SKILL.md` can convert user requests and available project evidence into reliable, proportionate briefs and handoffs.

## How to run

1. Open the target AI-agent client that supports the repository's Agent Skills format.
2. Make sure `project-understanding` is available to the agent.
3. Run each case in a fresh conversation, providing only the materials named in that case.
4. Save the agent's response as evidence. Do not coach the agent during the first run.
5. Score the response using `scorecard.md`.
6. Record the client/model, date, exact skill revision or commit, score, failures, and evidence in `results/PU-XX/evaluation.md`. Preserve the raw prompt and response when practical.
7. Keep observed behavior separate from reviewer scores. A run record may be complete while its score remains explicitly `Not scored` until an independent reviewer applies `scorecard.md`.

Do not mark a case as passed just because the response sounds plausible. Check whether it followed the expected behavior and accurately represented the supplied evidence.

## Cases

See [`cases.md`](cases.md).

Reusable inventory helper: [`scripts/count-extensions.sh`](scripts/count-extensions.sh). Its regression test is [`../../tests/test_count_extensions.sh`](../../tests/test_count_extensions.sh).

Recorded run: [`results/PU-05/evaluation.md`](results/PU-05/evaluation.md).

## Passing rule

For the first baseline, a case passes when it scores at least 80/100 and has no critical failure. Critical failures include inventing inspected evidence, treating assumptions as confirmed, overlooking an important conflict, or proceeding with a consequential/destructive action without appropriate authorization.

A passing result only applies to the tested agent/client configuration. It does not establish universal compatibility.
