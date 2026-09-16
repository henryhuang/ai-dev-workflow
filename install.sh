#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
COPILOT_HOME="${COPILOT_HOME:-$HOME/.copilot}"
AGENTS_DST="$COPILOT_HOME/agents"
INSTRUCTIONS_DST="$COPILOT_HOME/instructions"
BACKUP_ROOT="$COPILOT_HOME/backups/ai-dev-workflow"
TIMESTAMP="$(date +%Y%m%d-%H%M%S)"

AGENTS_SRC="$SCRIPT_DIR/.github/agents"
INSTRUCTIONS_SRC="$SCRIPT_DIR/.github/copilot-instructions.md"

if [[ ! -d "$AGENTS_SRC" ]]; then
  echo "Error: agent source directory not found: $AGENTS_SRC" >&2
  exit 1
fi

if [[ ! -f "$INSTRUCTIONS_SRC" ]]; then
  echo "Error: instructions source file not found: $INSTRUCTIONS_SRC" >&2
  exit 1
fi

mkdir -p "$AGENTS_DST" "$INSTRUCTIONS_DST"

backup_if_exists() {
  local target="$1"
  if [[ -f "$target" ]]; then
    local relative="${target#$COPILOT_HOME/}"
    local backup="$BACKUP_ROOT/$TIMESTAMP/$relative"
    mkdir -p "$(dirname "$backup")"
    cp "$target" "$backup"
    echo "  backup: $target -> $backup"
  fi
}

install_agent() {
  local src="$1"
  local base
  base="$(basename "$src" .md)"
  local dst="$AGENTS_DST/$base.agent.md"

  backup_if_exists "$dst"
  cp "$src" "$dst"
  echo "  installed: $dst"
}

echo "Installing AI Dev Workflow"
echo "Copilot home: $COPILOT_HOME"
echo

echo "Agents:"
for src in "$AGENTS_SRC"/*.md; do
  install_agent "$src"
done

instruction_target="$INSTRUCTIONS_DST/ai-dev-workflow.instructions.md"
backup_if_exists "$instruction_target"

{
  echo "---"
  echo "name: AI Dev Workflow"
  echo "description: Personal AI-assisted development rules"
  echo 'applyTo: "**"'
  echo "---"
  echo
  cat "$INSTRUCTIONS_SRC"
} > "$instruction_target"

echo
echo "Instructions:"
echo "  installed: $instruction_target"

echo
echo "Done."
echo "Restart VS Code or reload the window if the agents are not immediately visible."
echo "Use /agents in Copilot Chat to verify the custom agents."
