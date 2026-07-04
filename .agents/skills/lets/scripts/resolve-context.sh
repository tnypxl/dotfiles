#!/usr/bin/env bash
set -euo pipefail

# resolve-context.sh
#
# Locate the active stem, resolve domain and workflow selectors against
# the two-tier cascade, enforce coupling requirements, and emit the
# resolved context as eval-safe key=value lines to stdout.
#
# Cascade for both domains and workflows:
#   $PWD/.agents/<kind>/<name>.md   (project override — wins)
#   $HOME/.agents/<kind>/<name>.md  (default floor)
#
# Domain resolution uses three-tier precedence:
#   notebook domain > workflow-preset domain > session domain
#
# Exits nonzero with a message to stderr on any resolution or coupling
# failure. On success, prints only the keyed context to stdout.

# ---------------------------------------------------------------------------
# Frontmatter parser — reads the block between the first pair of --- lines.
# Skips comment lines. Returns empty string if key is absent or value empty.
# Use for: notebook.md, domain files, workflow files.
# ---------------------------------------------------------------------------
parse_frontmatter() {
    local file="$1"
    local key="$2"
    awk -v key="$key" '
        BEGIN { in_fm = 0; found_open = 0 }
        /^---[[:space:]]*$/ {
            if (!found_open) { found_open = 1; in_fm = 1; next }
            else             { exit }
        }
        !in_fm { next }
        /^[[:space:]]*#/ { next }
        {
            pat = "^[[:space:]]*" key "[[:space:]]*:[[:space:]]*"
            if (match($0, pat)) {
                val = substr($0, RSTART + RLENGTH)
                sub(/[[:space:]]*#.*$/, "", val)
                sub(/[[:space:]]*$/, "", val)
                print val
                exit
            }
        }
    ' "$file"
}

# ---------------------------------------------------------------------------
# Plain-YAML key parser — reads the whole file without frontmatter delimiters.
# Use for: session.yml (which carries bare YAML, no --- wrapping).
# ---------------------------------------------------------------------------
parse_yaml_key() {
    local file="$1"
    local key="$2"
    awk -v key="$key" '
        /^[[:space:]]*#/ { next }
        {
            pat = "^[[:space:]]*" key "[[:space:]]*:[[:space:]]*"
            if (match($0, pat)) {
                val = substr($0, RSTART + RLENGTH)
                sub(/[[:space:]]*#.*$/, "", val)
                sub(/[[:space:]]*$/, "", val)
                print val
                exit
            }
        }
    ' "$file"
}

# ---------------------------------------------------------------------------
# Cascade resolver — returns absolute path of first hit, or exits nonzero.
# Prints nothing (not empty string) when name is empty — caller checks $name.
# ---------------------------------------------------------------------------
resolve_cascade() {
    local kind="$1"   # "domains" or "workflows"
    local name="$2"
    local root="$3"

    local project_file="$root/.agents/${kind}/${name}.md"
    local home_file="$HOME/.agents/${kind}/${name}.md"

    if [[ -f "$project_file" ]]; then
        echo "$project_file"
    elif [[ -f "$home_file" ]]; then
        echo "$home_file"
    else
        echo "resolve-context: ${kind%s} '${name}' not found in cascade" >&2
        printf "  checked: %s\n" "$project_file" "$home_file" >&2
        exit 1
    fi
}

# ---------------------------------------------------------------------------
# Project root — walk up from $PWD looking for session.yml.
# ---------------------------------------------------------------------------
find_project_root() {
    local dir="$PWD"
    while [[ "$dir" != "/" ]]; do
        if [[ -f "$dir/session.yml" ]]; then
            echo "$dir"
            return 0
        fi
        dir="$(dirname "$dir")"
    done
    echo "resolve-context: no session.yml found at or above '$PWD'" >&2
    exit 1
}

# ===========================================================================
# Main
# ===========================================================================

ROOT="$(find_project_root)"
SESSION="$ROOT/session.yml"

# Read active stem
STEM="$(parse_yaml_key "$SESSION" "stem")"
if [[ -z "$STEM" ]]; then
    echo "resolve-context: 'stem:' is missing or empty in $SESSION" >&2
    exit 1
fi

# Locate the stem folder — first match of <digits>.<stem>/
STEM_DIR=""
for d in "$ROOT"/[0-9]*."$STEM"/; do
    if [[ -d "$d" ]]; then
        STEM_DIR="${d%/}"
        break
    fi
done

if [[ -z "$STEM_DIR" ]]; then
    echo "resolve-context: no stem folder matching '*.$STEM' found under '$ROOT'" >&2
    exit 1
fi

NOTEBOOK="$STEM_DIR/notebook.md"
if [[ ! -f "$NOTEBOOK" ]]; then
    echo "resolve-context: notebook.md not found at '$NOTEBOOK'" >&2
    exit 1
fi

# ---------------------------------------------------------------------------
# Read selectors from both sources
# ---------------------------------------------------------------------------
NB_DOMAIN="$(parse_frontmatter "$NOTEBOOK" "domain")"
NB_WORKFLOW="$(parse_frontmatter "$NOTEBOOK" "workflow")"
SESS_DOMAIN="$(parse_yaml_key "$SESSION" "domain")"
SESS_WORKFLOW="$(parse_yaml_key "$SESSION" "workflow")"

# ---------------------------------------------------------------------------
# Resolve workflow (needed first — its preset may supply the domain)
# ---------------------------------------------------------------------------
WF_NAME="${NB_WORKFLOW:-${SESS_WORKFLOW:-}}"
WF_FILE=""

if [[ -n "$WF_NAME" ]]; then
    WF_FILE="$(resolve_cascade "workflows" "$WF_NAME" "$ROOT")"
fi

# ---------------------------------------------------------------------------
# Resolve domain — three-tier precedence:
#   1. notebook domain
#   2. workflow-preset domain (from resolved workflow frontmatter)
#   3. session domain
# ---------------------------------------------------------------------------
DOMAIN_NAME=""
if [[ -n "$NB_DOMAIN" ]]; then
    DOMAIN_NAME="$NB_DOMAIN"
elif [[ -n "$WF_FILE" ]]; then
    WF_PRESET_DOMAIN="$(parse_frontmatter "$WF_FILE" "domain")"
    DOMAIN_NAME="${WF_PRESET_DOMAIN:-${SESS_DOMAIN:-}}"
else
    DOMAIN_NAME="${SESS_DOMAIN:-}"
fi

DOMAIN_FILE=""
if [[ -n "$DOMAIN_NAME" ]]; then
    DOMAIN_FILE="$(resolve_cascade "domains" "$DOMAIN_NAME" "$ROOT")"
fi

# ---------------------------------------------------------------------------
# Coupling validation
# ---------------------------------------------------------------------------

# Domain coupling: requires_workflow
if [[ -n "$DOMAIN_FILE" ]]; then
    REQ_WF="$(parse_frontmatter "$DOMAIN_FILE" "requires_workflow")"
    if [[ -n "$REQ_WF" ]]; then
        if [[ -z "$WF_NAME" || "$WF_NAME" != "$REQ_WF" ]]; then
            echo "resolve-context: domain '$DOMAIN_NAME' requires workflow '$REQ_WF', but no matching workflow is selected" >&2
            exit 1
        fi
    fi
fi

# Workflow coupling: requires_domain
if [[ -n "$WF_FILE" ]]; then
    REQ_DOM="$(parse_frontmatter "$WF_FILE" "requires_domain")"
    if [[ -n "$REQ_DOM" ]]; then
        if [[ -z "$DOMAIN_NAME" || "$DOMAIN_NAME" != "$REQ_DOM" ]]; then
            echo "resolve-context: workflow '$WF_NAME' requires domain '$REQ_DOM', but no matching domain is selected" >&2
            exit 1
        fi
    fi
fi

# ---------------------------------------------------------------------------
# Emit resolved context
# ---------------------------------------------------------------------------
echo "DOMAIN_NAME=${DOMAIN_NAME}"
echo "DOMAIN_FILE=${DOMAIN_FILE}"
echo "WORKFLOW_NAME=${WF_NAME}"
echo "WORKFLOW_FILE=${WF_FILE}"
