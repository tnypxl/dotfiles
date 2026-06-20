#!/usr/bin/env bash
#
# Symlink this directory's agents and skills into a Claude config dir.
#
#   install.sh --claude              install (symlink) into ~/.claude
#   install.sh --claude --uninstall  remove the symlinks this script created
#
# Agents are the *.md files in this directory that begin with YAML frontmatter
# (SYSTEM.md and other plain docs are ignored). Skills are the subdirectories of
# ./skills/ that contain a SKILL.md (so ./skills/scripts/ is ignored).
#
# Override the target root with CLAUDE_HOME (defaults to ~/.claude).
set -euo pipefail

SOURCE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CLAUDE_HOME="${CLAUDE_HOME:-$HOME/.claude}"

usage() {
  cat <<'EOF'
Symlink this directory's agents and skills into a Claude config dir.

  install.sh --claude              install (symlink) into ~/.claude
  install.sh --claude --uninstall  remove the symlinks this script created

Agents are the *.md files in this directory that begin with YAML frontmatter
(SYSTEM.md and other plain docs are ignored). Skills are the subdirectories of
./skills/ that contain a SKILL.md (so ./skills/scripts/ is ignored).

Override the target root with CLAUDE_HOME (defaults to ~/.claude).
EOF
}

# A symlink is "ours" if its target matches src ignoring a trailing slash
# (pre-existing skill links were created with one; we create them without).
links_to() { [[ "$(readlink "$1")" == "${2%/}" || "$(readlink "$1")" == "${2%/}/" ]]; }

# Print the absolute path of every agent definition (root *.md with frontmatter).
collect_agents() {
  local f
  for f in "$SOURCE_DIR"/*.md; do
    [[ -e "$f" ]] || continue
    [[ "$(head -n1 "$f")" == "---" ]] && printf '%s\n' "$f"
  done
}

# Print the absolute path of every skill (./skills/*/ holding a SKILL.md).
collect_skills() {
  local d
  for d in "$SOURCE_DIR"/skills/*/; do
    [[ -f "${d}SKILL.md" ]] && printf '%s\n' "${d%/}"
  done
}

link_one() {
  local src="$1" dest="$2"
  mkdir -p "$(dirname "$dest")"
  if [[ -L "$dest" ]]; then
    links_to "$dest" "$src" && { echo "  ok    ${dest/#$HOME/\~} (already linked)"; return; }
    echo "  warn  ${dest/#$HOME/\~} -> $(readlink "$dest") (not ours; skipping)"; return
  fi
  [[ -e "$dest" ]] && { echo "  warn  ${dest/#$HOME/\~} exists, not a symlink (skipping)"; return; }
  ln -s "$src" "$dest"
  echo "  link  ${dest/#$HOME/\~}"
}

unlink_one() {
  local src="$1" dest="$2"
  [[ -L "$dest" ]] || return 0
  if links_to "$dest" "$src"; then
    rm "$dest"; echo "  rm    ${dest/#$HOME/\~}"
  else
    echo "  skip  ${dest/#$HOME/\~} -> $(readlink "$dest") (not ours)"
  fi
}

apply() {
  local fn="$1" src
  echo "Agents -> ${CLAUDE_HOME/#$HOME/\~}/agents/"
  while IFS= read -r src; do "$fn" "$src" "$CLAUDE_HOME/agents/$(basename "$src")"; done < <(collect_agents)
  echo "Skills -> ${CLAUDE_HOME/#$HOME/\~}/skills/"
  while IFS= read -r src; do "$fn" "$src" "$CLAUDE_HOME/skills/$(basename "$src")"; done < <(collect_skills)
}

target="" action="install"
while [[ $# -gt 0 ]]; do
  case "$1" in
    --claude)    target="claude" ;;
    --uninstall) action="uninstall" ;;
    -h|--help)   usage; exit 0 ;;
    *) echo "error: unknown option '$1'" >&2; usage >&2; exit 2 ;;
  esac
  shift
done

[[ -n "$target" ]] || { echo "error: a target is required (--claude)" >&2; usage >&2; exit 2; }

case "$action" in
  install)   apply link_one ;;
  uninstall) apply unlink_one ;;
esac
