# AI Dev Workflow

Reusable GitHub Copilot custom agents for AI-assisted development.

This repository is designed around three inputs: a complete feature file, a short feature request, or a bug report.

## Agent files

GitHub Copilot repository agents live in `.github/agents/*.md`.

- `feature-planner` — complete feature file -> implementation plan
- `feature-implementer` — approved plan -> implementation + validation
- `light-feature` — short request -> mini-spec -> implementation
- `bugfix` — reproduce -> root cause -> regression test -> fix
- `reviewer` — independent requirement/diff verification; first pass is read-only

## Always-on rules

- `.github/copilot-instructions.md` contains repository-wide Copilot instructions.
- `AGENTS.md` contains vendor-neutral operating rules that can also be consumed by agent-capable tools.

## Recommended daily workflow

### Complete feature file
1. Start with `feature-planner`.
2. Review its implementation plan.
3. Continue with `feature-implementer`.
4. Inspect the diff yourself.
5. Start a fresh conversation with a different model using `reviewer`.
6. Resolve confirmed findings.
7. Review the final diff and commit.

### Short feature request
1. Use `light-feature`.
2. Ensure its mini-spec and AC match your intent.
3. Let it implement and validate.
4. Run `reviewer` in a fresh conversation.
5. Human final diff review.

### Bug
1. Use `bugfix`.
2. Require reproduction/root-cause evidence before production changes when feasible.
3. Prefer a regression test that fails before the fix.
4. Run `reviewer` after the fix.
5. Human final diff review.

## Core principles

1. Requirements are the source of truth.
2. Implementation and review are separate roles.
3. Prefer deterministic checks over model judgment.
4. Tests validate required behavior, not the implementation's assumptions.
5. Avoid unrelated refactors.
6. A green test suite is necessary but not sufficient.
7. Final human diff review remains mandatory.

## Using this as a template

Copy these files into the root of an actual project:

```text
AGENTS.md
.github/
  copilot-instructions.md
  agents/
    feature-planner.md
    feature-implementer.md
    light-feature.md
    bugfix.md
    reviewer.md
```

Then add project-specific build, test, architecture, and coding conventions to `.github/copilot-instructions.md` or a project-local `AGENTS.md`.
