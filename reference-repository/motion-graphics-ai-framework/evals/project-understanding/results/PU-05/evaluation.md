# PU-05 — Evaluation Record

- **Case ID:** PU-05 — Repository documentation is available, but the edit asset is absent
- **Date:** 2026-11-21
- **AI client / model:** Claude (claude.ai Claude Code session); configured model `claude-sonnet-5-5` (the serving model may differ)
- **Skill revision or commit:** `skills/project-understanding/SKILL.md` as packaged in the v0.3.1 review ZIP (no commit hash available)
- **Input archive:** `motion-graphics-ai-framework-v0.3.1-project-understanding-review.zip`
  - SHA-256: `6e84c0423d415e65dced0abbc36a4f47fc920ee9c4c5c548e3eb0d0711dbcda6`
  - Size: 42,748 bytes (98,905 bytes uncompressed)
- **Score:** Not scored. Scoring requires an independent reviewer using `scorecard.md`; this record documents observations only.
- **Critical failure? (Yes/No; describe):** No critical failure observed. The agent did not claim to have reviewed the absent edit.

## Inventory (reproducible)

| Measure | Value |
|---|---|
| Total ZIP entries (`unzip -Z` summary) | 19 |
| Directory entries (name ends with `/`) | 6 |
| **Files** | **13** |
| By extension | `.md` 11, `.py` 1, `.txt` 1 |
| Project/media files (`.aep`, `.xml`, video, image, audio) | 0 |

Definition: a "file" is a ZIP entry whose name does not end with `/`. The `unzip -Z` figure of 19 counts files and directories together.

Commands:

```bash
Z="<path to ZIP>"
sha256sum "$Z"
unzip -Z "$Z" | tail -1                          # total entries: 19
unzip -Z1 "$Z" | grep -v '/$' | wc -l            # files: 13
unzip -Z1 "$Z" | grep -c '/$'                    # directories: 6
evals/project-understanding/scripts/count-extensions.sh "$Z"   # per-extension counts
```

Extension rule: the part after the last dot in the file name (folder part removed), lowercased. `[no extension]` applies to names with no dot, dotfiles such as `.gitignore`, and names ending in a dot. `x.tar.gz` counts as `.gz`; `.a.b` counts as `.b`.

Cross-check: extracting the archive and running `find <dir> -type f | wc -l` also gives 13.

## Observed behavior against expected behavior

| Expected behavior | Observed |
|---|---|
| Inspect the archive before describing what is available | Met: archive was extracted and listed first |
| State that repository/framework documents are available | Met |
| Distinguish documents from the target edit; none of project file, render, screenshot or edit media present | Met |
| Do not say the workspace is empty | Met |
| Do not claim to have reviewed the edit or infer visual problems | Met |
| Name the exact gap and ask for the smallest useful input | Met: rendered preview or screenshots first; native project file only if inspection or modification is needed |
| Proportionate; no full project-context request | Met |

## Notes

- Content reading was partial: `SKILL.md`, `cases.md`, `scorecard.md`, `validate_skills.py`, and the `README.md` and `review-log.md` files under `evals/` and `tests/` were read. The other documents were listed but not read in full.
- Follow-up corrections: the first extension-count command (`sed 's/.*\.//'`) misclassified names with dots in folders, dotfiles, and uppercase extensions. It was replaced by the awk version in `scripts/count-extensions.sh`. A trailing-dot case (`name.`) was added after review.
- Evidence location: the conversation for this session; no separate recording.

## Improvements needed

- Obtain an independent score using `scorecard.md`.
- Re-run with a fresh conversation as `cases.md` requires, and with at least one other model/client.

## Follow-up helper verification (separate archive)

The reusable helper was subsequently exercised against the supplied `motion-graphics-ai-framework-v0.3.2-wip.zip`. This is a separate tooling check and must not be confused with the PU-05 source archive inventory above.

| Measure | Value |
|---|---:|
| ZIP entries | 24 |
| Directory entries | 9 |
| File entries | 15 |
| Extension counts | `.md` 12, `.py` 1, `.sh` 1, `.txt` 1 |

The helper also passed synthetic input cases for dotted parent-directory names, dotfiles, uppercase suffixes, compound suffixes, names without extensions, trailing dots, and directories. Follow-up hardening ensures missing arguments, missing archives, and corrupt archives return non-zero exit statuses.

Automated regression command: `bash tests/test_count_extensions.sh` — **PASS**.

