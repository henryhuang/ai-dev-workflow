# AI Dev Workflow

Reusable GitHub Copilot custom agents for AI-assisted development.

## Workflows

### Full feature
Feature file -> implementation plan -> implementation -> deterministic checks -> independent review -> human diff review -> commit

### Lightweight feature
Short request -> mini spec -> implementation -> deterministic checks -> independent review -> human diff review -> commit

### Bug fix
Bug report -> reproduce -> root cause -> failing regression test -> fix -> passing regression test -> broader checks -> independent review -> human diff review -> commit

## Agents

- `feature-planner`: turns a complete feature file into an implementation plan. Does not edit code.
- `feature-implementer`: implements the approved plan and runs deterministic validation.
- `light-feature`: turns a short request into a testable mini-spec, then implements it.
- `bugfix`: reproduces first, finds root cause, adds a regression test, then fixes.
- `reviewer`: independently checks the diff against requirements and acceptance criteria before any corrective edits.

## Core rules

1. Requirements are the source of truth.
2. Implementation and review are separate roles.
3. Prefer deterministic checks over model judgment.
4. Tests should validate required behavior, not mirror implementation.
5. Avoid unrelated refactors.
6. Final human diff review remains mandatory.
