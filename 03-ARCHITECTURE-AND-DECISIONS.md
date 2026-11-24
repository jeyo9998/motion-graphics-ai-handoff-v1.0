# Architecture and Established Decisions

## Three conceptual layers

1. **Shared intelligence**
   - `project-understanding`
   - `motion-graphics-principles`

2. **Application adaptation**
   - `application-adaptation`
   - Alight Motion references
   - After Effects references

3. **Active execution and evaluation**
   - `motion-graphics-execution`
   - `hybrid-execution`
   - `visual-evaluation`
   - `error-analysis` when needed

## Seven initial Skills

| Skill | Primary responsibility |
|---|---|
| `project-understanding` | Establish what the user wants, available project context, and success criteria. |
| `motion-graphics-principles` | Reusable creative and animation principles independent of one application. |
| `application-adaptation` | Translate creative intent into verified procedures for the selected application. |
| `motion-graphics-execution` | Coordinate approved creative work from brief through checked completion. |
| `hybrid-execution` | Choose and carry out an available technical route for a defined operation. |
| `visual-evaluation` | Assess results against user-approved acceptance criteria. |
| `error-analysis` | Diagnose discrepancies, separate hypotheses from confirmed causes, and verify corrections. |

Only `project-understanding` is implemented in the supplied v0.3.2-reviewed archive. The other six are planned, not implemented there.

## Established decisions from repository documentation

- Target multiple compatible AI-agent platforms.
- Initial application priorities: Alight Motion and Adobe After Effects equally.
- Operating mode: active collaborator with bounded authority.
- Execution approach: hybrid.
- Development method: incremental.
- Workflow values: Simple, Structured, Evaluated, Improved.
- Shared creative intent is separated from application-specific implementation.
- Skills describe capabilities; tools provide access.
- Handoffs should be selective; not every task needs every Skill.
- Evidence and limitations must be recorded accurately.

## Hybrid execution methods

- **A — Direct file manipulation:** only when format and operation are sufficiently understood and a safe, recoverable workflow exists.
- **B — Scripting/API:** use an application-supported interface when available; verify app/version, permissions, dependencies, and side effects.
- **C — Application interaction:** use authorized UI control or guide the user when direct control is unavailable.

The method is selected for the actual operation, application, file format, available tools, permissions, and reversibility. Do not assume the two target apps expose equivalent interfaces.

## Permission model

The agent may proactively inspect accessible context, identify missing dependencies, propose next steps, and perform authorized low-risk reversible work.

Seek appropriate approval before destructive, irreversible, externally visible, or scope-changing actions. Preserve originals where practical. Distinguish planning, attempting, and verifying an action.

## Development sequence

The architecture map describes this sequence:

1. Review and baseline `project-understanding`.
2. Complete `motion-graphics-principles`.
3. Develop `application-adaptation`.
4. Develop `motion-graphics-execution` and `hybrid-execution`.
5. Develop `visual-evaluation` and `error-analysis`.
6. Integrate and benchmark.

The immediate working gate is the evaluation and improvement of `project-understanding`. Do not skip it without explicit owner approval.
