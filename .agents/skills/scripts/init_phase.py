#!/usr/bin/env python3
"""Scaffold session.yml and a draft phase document for a workflow phase.

Usage: init_phase.py <phase> <stem>

Phases: discover, discuss, approach, research, plan, execute, verify

Behavior:
- Creates session.yml in the current directory if missing, with the given phase and stem.
- If session.yml exists with a different phase, exits with an error.
- Creates <stem>.<phase>.md from the phase's template with status: draft.
- Refuses to overwrite an existing <stem>.<phase>.md.

Domain-agnostic: emits markdown templates only.
"""
from __future__ import annotations

import re
import sys
from pathlib import Path

PHASES = ("discover", "discuss", "approach", "research", "plan", "execute", "verify")

TEMPLATES: dict[str, str] = {
    "discover": """---
title:
date:
status: draft
---

## Surface

<!-- What the human has voiced. Direct quotes or close paraphrases. No interpretation. -->

## Tensions

<!-- Competing pulls the human seems to be navigating. Each tension named in one short line. -->

## Candidate Intents

<!-- Possible directions, distinct from each other. No recommendation. Maximum five. -->

## Signals to Watch For

<!-- Heuristics that would tell the human which candidate intent is the right one. -->

## Open Questions

<!-- Format: - [ ] Q1: <question> -->
""",
    "discuss": """---
title:
date:
status: draft
---

## Intent

<!-- The human writes this. The skill never modifies it. -->

## Synthesis

<!-- The skill maintains this as shared understanding develops. -->

## Scope

### In

### Out

## Constraints

<!-- Non-negotiables, known limitations, fixed conditions. -->

## Open Questions

<!-- Format: - [ ] Q1: <question> -->
""",
    "approach": """---
title:
date:
status: draft
---

## Thesis

<!-- Generated on invocation. Human may modify before proceeding. Two paragraphs max. -->

## Rationale

<!-- Why this approach over alternatives. Generated on invocation. Human may modify. -->

## Structure

<!-- High-level shape of the solution. Components and relationships. Directional, not prescriptive. -->

## Assumptions

<!-- What is being taken as true for this approach to hold. Falsifiable. -->

## Risks

<!-- What could challenge or invalidate this approach. Specific. -->

## Open Questions

<!-- Format: - [ ] Q1: <question> -->
""",
    "research": """---
title:
date:
status: draft
---

## Scope

<!-- What is being investigated and why. Bounded before investigation begins. -->

## Findings

<!-- Factual, neutral observations. No interpretation. -->

## Implications

<!-- What the findings mean for the approach and plan. Separate from Findings. -->

## Gaps

<!-- What could not be determined. -->

## Open Questions

<!-- Format: - [ ] Q1: <question> -->
""",
    "plan": """---
title:
date:
status: draft
---

## Overview

<!-- Brief statement of what this plan covers and which approach it executes against. -->

## Research Summary

<!-- Condensed synthesis of <stem>.research.md findings relevant to task generation.
     Remove this section if no research document was generated. -->

## T1 - Task Title

Description of what this task is and why it exists within the broader plan.

- [ ] Depends on: <none>
- [ ] Checklist item
- [ ] Another checklist item

## Approach Conflicts

<!-- Populated only when grounding reveals conflicts with the approach.
     Each entry: what was found, why it conflicts, recommended change.
     When this section has content, halt planning and return to approach. -->

## Open Questions

<!-- Format: - [ ] Q1: <question> -->
""",
    "execute": """---
title:
date:
status: draft
---

## Overview

<!-- Brief statement of which plan is being executed and any relevant starting conditions. -->

## Execution Log

<!-- Chronological entries. Append-only. Never rewrite or delete a prior entry. -->

### Ex1 — T1: Brief description of action taken

What was done and how. Whether it met the task's requirements in alignment with the approach and plan.
Any divergence or unplanned decision captured here with reasoning.

## Open Questions

<!-- Format: - [ ] Q1: <question> -->
""",
    "verify": """---
title:
date:
status: draft
---

## Plan Verification

<!-- Checks mapped to plan tasks. Mirror T1, T2 headings where helpful. -->

- [ ] T1: <verification check>

## Outcome Verification

<!-- Checks mapped to original intent. Required completion gate. -->

- [ ] <outcome check traced to intent>

## Failures

<!-- Populated only when verification items do not pass.
     Each entry: what failed, which area (plan/outcome), offending task reference. -->

## Open Questions

<!-- Format: - [ ] Q1: <question> -->
""",
}


def read_session_phase(session_path: Path) -> str | None:
    """Return the phase recorded in session.yml, or None if not found."""
    text = session_path.read_text()
    match = re.search(r"^phase:\s*(\S+)\s*$", text, flags=re.MULTILINE)
    return match.group(1) if match else None


def write_session(session_path: Path, phase: str, stem: str) -> None:
    session_path.write_text(f"stem: {stem}\nphase: {phase}\nnote:\n")


def main(argv: list[str]) -> int:
    if len(argv) != 3:
        print(__doc__, file=sys.stderr)
        return 2

    phase, stem = argv[1], argv[2]

    if phase not in PHASES:
        print(f"error: unknown phase '{phase}'. valid: {', '.join(PHASES)}", file=sys.stderr)
        return 2

    if not re.fullmatch(r"[A-Za-z0-9._-]+", stem):
        print(f"error: stem '{stem}' must be filename-friendly (letters, digits, dot, dash, underscore)", file=sys.stderr)
        return 2

    cwd = Path.cwd()
    session_path = cwd / "session.yml"

    if session_path.exists():
        existing_phase = read_session_phase(session_path)
        if existing_phase is None:
            print("error: session.yml exists but has no readable 'phase:' field", file=sys.stderr)
            return 1
        if existing_phase != phase:
            print(
                f"error: session.yml has phase '{existing_phase}', not '{phase}'.\n"
                f"flip the phase in session.yml manually before scaffolding a {phase} document.",
                file=sys.stderr,
            )
            return 1
    else:
        write_session(session_path, phase, stem)
        print(f"created {session_path.name} (stem={stem}, phase={phase})")

    doc_path = cwd / f"{stem}.{phase}.md"
    if doc_path.exists():
        print(f"error: {doc_path.name} already exists; refusing to overwrite", file=sys.stderr)
        return 1

    doc_path.write_text(TEMPLATES[phase])
    print(f"created {doc_path.name}")
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv))
