#!/usr/bin/env python3
"""Scaffold a stem folder and a draft phase document for a workflow phase.

Usage: init_phase.py <phase> <stem>

Phases: discover, discuss, approach, research, plan, execute, verify

Run this from the project root — the directory that holds the single session.yml
cursor and all the numbered stem folders. session.yml names the stem and phase you
are currently working:

    stem: redesign-onboarding
    phase: discover
    note:

Each stem lives in its own folder named <index>.<stem>, where <index> is its
chronological number. Phase documents inside are named <index>.<order>.<phase>.md,
where <order> is the phase's fixed position in the chain (discover=1 ... verify=7).

Behavior:
- Creates session.yml at the project root if missing, with the given stem and phase.
  If it exists, reads the stem and phase from it; the requested phase must match
  (research is allowed while the phase is 'plan'). session.yml is otherwise
  human-owned and never modified here.
- Finds the stem's folder (<index>.<stem>). If none exists, allocates the next
  index (1 + the highest index prefix among existing stem folders; 1 if none) and
  creates the folder.
- Creates <index>.<order>.<phase>.md from the phase's template with status: draft.
- Refuses to overwrite an existing phase document.

Domain-agnostic: emits markdown templates only.
"""
from __future__ import annotations

import re
import sys
from pathlib import Path

PHASES = ("discover", "discuss", "approach", "research", "plan", "execute", "verify")

# Fixed position of each phase in the chain. Used as the second filename segment so
# a directory listing sorts in workflow order. A skipped phase (commonly research)
# simply leaves a gap; the sequence still reads true.
ORDER = {phase: i for i, phase in enumerate(PHASES, start=1)}

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

<!-- Possible directions, distinct from each other. No recommendation. One per turn; slow ceiling of three. -->

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

<!-- Condensed synthesis of the research document's (<index>.4.research.md) findings relevant to task generation.
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


def read_session_field(session_path: Path, field: str) -> str | None:
    """Return a scalar field recorded in session.yml, or None if not found."""
    text = session_path.read_text()
    match = re.search(rf"^{field}:\s*(\S+)\s*$", text, flags=re.MULTILINE)
    return match.group(1) if match else None


def find_stem_folder(root: Path, stem: str) -> Path | None:
    """Return the existing <index>.<stem> folder for this stem, or None."""
    for child in root.iterdir():
        if child.is_dir() and re.fullmatch(rf"\d+\.{re.escape(stem)}", child.name):
            return child
    return None


def allocate_index(root: Path) -> int:
    """Next free stem index: 1 + the highest numeric prefix among stem folders."""
    highest = 0
    for child in root.iterdir():
        if child.is_dir():
            match = re.match(r"(\d+)\.", child.name)
            if match:
                highest = max(highest, int(match.group(1)))
    return highest + 1


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

    root = Path.cwd()
    session_path = root / "session.yml"

    if session_path.exists():
        existing_stem = read_session_field(session_path, "stem")
        existing_phase = read_session_field(session_path, "phase")
        if existing_phase is None:
            print("error: session.yml exists but has no readable 'phase:' field", file=sys.stderr)
            return 1
        if existing_stem != stem:
            print(
                f"error: session.yml stem is '{existing_stem}', not '{stem}'.\n"
                f"set the stem (and phase) in session.yml before scaffolding for '{stem}'.",
                file=sys.stderr,
            )
            return 1
        # Research is generated from within the plan phase, so it is allowed while
        # the session phase is 'plan' without flipping the phase. Every other phase
        # must match the session phase exactly.
        phase_ok = existing_phase == phase or (phase == "research" and existing_phase == "plan")
        if not phase_ok:
            print(
                f"error: session.yml has phase '{existing_phase}', not '{phase}'.\n"
                f"flip the phase in session.yml manually before scaffolding a {phase} document.",
                file=sys.stderr,
            )
            return 1
    else:
        write_session(session_path, phase, stem)
        print(f"created {session_path.name} (stem={stem}, phase={phase})")

    folder = find_stem_folder(root, stem)
    if folder is None:
        index = allocate_index(root)
        folder = root / f"{index}.{stem}"
        folder.mkdir()
        print(f"created {folder.name}/")
    else:
        index = int(folder.name.split(".", 1)[0])

    doc_path = folder / f"{index}.{ORDER[phase]}.{phase}.md"
    if doc_path.exists():
        print(f"error: {folder.name}/{doc_path.name} already exists; refusing to overwrite", file=sys.stderr)
        return 1

    doc_path.write_text(TEMPLATES[phase])
    print(f"created {folder.name}/{doc_path.name}")
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv))
