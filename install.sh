#!/usr/bin/env bash
# Install ccskills into Claude Code and/or Grok skill directories.
set -euo pipefail

ROOT="$(cd "$(dirname "$0")" && pwd)"
SKILLS_SRC="$ROOT/skills"

ALL_SKILLS=(
  managing-research-projects
  cs-paper-structure
  scheduled-patrol
  karpathy-guidelines
  frontend-design
  grill-me
  grilling
  handoff
)

usage() {
  cat <<'EOF'
Usage: ./install.sh [options] [skill-name ...]

Options:
  --claude    Install to ~/.claude/skills
  --grok      Install to ~/.grok/skills
  --cursor    Install to ~/.cursor/skills
  --all       Install to every existing target (default if no target flag)
  -h, --help  Show help

If no skill names are given, install all skills.
EOF
}

targets=()
skills=()

while [[ $# -gt 0 ]]; do
  case "$1" in
    --claude) targets+=("$HOME/.claude/skills"); shift ;;
    --grok)   targets+=("$HOME/.grok/skills"); shift ;;
    --cursor) targets+=("$HOME/.cursor/skills"); shift ;;
    --all)    targets=("$HOME/.claude/skills" "$HOME/.grok/skills" "$HOME/.cursor/skills"); shift ;;
    -h|--help) usage; exit 0 ;;
    -*)
      echo "Unknown option: $1" >&2
      usage >&2
      exit 1
      ;;
    *)
      skills+=("$1")
      shift
      ;;
  esac
done

if [[ ${#targets[@]} -eq 0 ]]; then
  for d in "$HOME/.claude/skills" "$HOME/.grok/skills" "$HOME/.cursor/skills"; do
    [[ -d "$(dirname "$d")" ]] || mkdir -p "$(dirname "$d")"
    targets+=("$d")
  done
fi

if [[ ${#skills[@]} -eq 0 ]]; then
  skills=("${ALL_SKILLS[@]}")
fi

for name in "${skills[@]}"; do
  src="$SKILLS_SRC/$name"
  if [[ ! -d "$src" || ! -f "$src/SKILL.md" ]]; then
    echo "error: skill not found: $name ($src)" >&2
    exit 1
  fi
done

for dest_root in "${targets[@]}"; do
  mkdir -p "$dest_root"
  echo "→ $dest_root"
  for name in "${skills[@]}"; do
    rm -rf "$dest_root/$name"
    cp -R "$SKILLS_SRC/$name" "$dest_root/$name"
    echo "  installed $name"
  done
done

echo "Done. Restart the agent session (or run: grok inspect) to pick up skills."
