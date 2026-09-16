# AI Dev Workflow

Personal GitHub Copilot custom agents for AI-assisted development.

This repository is the source of truth for a user-level workflow. Install it into `~/.copilot` so the agents are available across projects without adding AI files to company repositories.

## Install

Clone this private repository on a machine, then run the installer.

### macOS / Linux / WSL

```bash
git clone git@github.com:henryhuang/ai-dev-workflow.git
cd ai-dev-workflow
bash install.sh
```

### Windows PowerShell

```powershell
git clone git@github.com:henryhuang/ai-dev-workflow.git
cd ai-dev-workflow
powershell -ExecutionPolicy Bypass -File .\install.ps1
```

The installer writes only to your user profile:

```text
~/.copilot/
  agents/
    feature-planner.agent.md
    feature-implementer.agent.md
    light-feature.agent.md
    bugfix.agent.md
    reviewer.agent.md

  instructions/
    ai-dev-workflow.instructions.md

  backups/
    ai-dev-workflow/
```

Existing files with the same names are backed up before replacement. Re-running the installer is safe and updates your local copies from this repository.

You can override the installation root with `COPILOT_HOME`.

```bash
COPILOT_HOME=/some/path bash install.sh
```

After installation, reload VS Code if needed and type `/agents` in Copilot Chat to verify the agents.

## Workflows

### Complete feature file

1. `feature-planner`
2. Review the implementation plan.
3. `feature-implementer`
4. Human first-pass diff review.
5. Start a fresh conversation with a different model using `reviewer`.
6. Resolve confirmed findings.
7. Human final diff review.
8. Commit.

### Short feature request

1. `light-feature`
2. Confirm the generated mini-spec and acceptance criteria.
3. Let it implement and run deterministic checks.
4. Run `reviewer` in a fresh conversation.
5. Human final diff review.

### Bug fix

1. `bugfix`
2. Reproduce when feasible.
3. Identify root cause.
4. Prefer a failing regression test before the fix.
5. Apply the smallest correct fix.
6. Run broader checks.
7. Run `reviewer`.
8. Human final diff review.

## Agents

- `feature-planner` — complete feature file -> implementation plan
- `feature-implementer` — approved plan -> implementation + validation
- `light-feature` — short request -> mini-spec -> implementation
- `bugfix` — reproduce -> root cause -> regression test -> fix
- `reviewer` — independent requirement/diff verification; first pass is review-only

## Core principles

1. Requirements are the source of truth.
2. Implementation and review are separate roles.
3. Prefer deterministic checks over model judgment.
4. Tests validate required behavior, not the implementation's assumptions.
5. Avoid unrelated refactors.
6. A green test suite is necessary but not sufficient.
7. Final human diff review remains mandatory.

## Updating another machine

Pull the latest workflow and rerun the installer:

```bash
cd ai-dev-workflow
git pull
bash install.sh
```

On Windows, rerun `install.ps1` instead.
