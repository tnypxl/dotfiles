---
name: lets
description: Stage a piece of work through one collaborative harness — discuss, research, plan, or execute a stem. Invoked as `/lets <verb> <prompt>` where verb is one of discuss, research, plan, execute. Also use whenever the human says "let's discuss/plan/research/execute", references a stem's notebook.md/research.md/plan.md/execute.md, or wants to think a piece of work through in stages and capture it in durable documents — for code, writing, decisions, research, or personal planning. The verb names the action; there is no phase gate.
---

# /lets

Read [`../WORKFLOW.md`](../WORKFLOW.md) before acting — it is the shared contract (the stem, the four artifacts, living vs. ledger, status, cadence, drift, voice). This skill is the dispatcher and the per-verb playbooks; the contract lives there.

## Dispatch

Input is `<verb> <prompt>`. The first token is the verb; the rest is the prompt.

1. **Verb** — one of `discuss`, `research`, `plan`, `execute`. If missing or unrecognized, ask which; do not guess.
2. **Stem** — read `session.yml` at the project root for `stem`. If `session.yml` is missing, ask the human for a stem name, then create `session.yml` (`stem` + empty `note`). Find the stem folder beside it (`<index>.<stem>`); if none exists, allocate the next index (`1 +` highest existing stem index, else `1`) and create the folder.
3. **Artifact** — map verb → file: `discuss`→`notebook.md`, `research`→`research.md`, `plan`→`plan.md`, `execute`→`execute.md`. If it doesn't exist, scaffold it from the template below with `status: active`.
4. **Lock guard** — if the target artifact's frontmatter is `status: locked`, do not write. Say so and stop. (During an execute review, if a correction sweep reaches a locked upstream artifact, surface the contradiction and ask to unlock rather than editing.)
5. **Domain** — if the notebook's frontmatter sets `domain: <name>`, resolve `<name>.md` against `$PWD/.agents/domains/` then `~/dotfiles/.agents/domains/`, and read the first hit as context for shaping deliverables. Optional; skip if unset or absent.

Then run the verb's playbook, one or two threads, and hand back.

## discuss → notebook.md

A real back-and-forth that shapes the notebook. Not a form to fill.

- Advance **Objective** and **Approach** as living sections — rewrite clean when understanding moves, leave untouched when it doesn't.
- Surface **one or two** open questions per turn, no more. On resolution, mark the question `[x]` with its resolution in the ledger, and fold the consequence into Objective/Approach if it changed them.
- Mid-conversation fact-checks are welcome: a narrow web lookup, or the `researcher` subagent in inline-lookup mode for anything heavier. These are ephemeral — they write nothing to `research.md`. A fact persists only if it lands in Objective/Approach.
- Never write the human's **Notes** section.

## research → research.md

Deliberate investigation, delegated to the `researcher` subagent with an already-bounded scope.

- Bound the scope first (from the notebook and the prompt); hand the subagent that scope.
- Meter its return into `research.md` one or two threads at a time — keep Findings (neutral) separate from Implications (what they mean). Record Gaps honestly.
- If a finding conflicts with the notebook's Approach, surface it; correction is the human re-running `discuss`.

## plan → plan.md

Decomposition toward the Approach, delegated to the `planner` subagent.

- One task = one outcome confirmable by a single check. Split anything that joins outcomes with "and."
- Each task carries a why-it-exists line, a checklist, and dependencies as the first item (`Depends on: <none>` when there are none).
- Meter proposed tasks into `plan.md` a few at a time; the skill assigns the permanent numbers, not the subagent.

## execute → execute.md

The work itself, delegated to the `executor` subagent (the only one that writes external artifacts).

- Hand the executor one task (or a tight bounded set). Write its report into `execute.md` as a log entry; the log is a ledger (append-only).
- Tick the task in `plan.md` when done.
- **Review each finished task for drift** (see WORKFLOW.md): would the notebook read differently now? If the human judges it does, run the correction sweep — re-run the verb for the layer that drifted (`plan`, or `discuss` then `plan`). The skill never decides drift on its own; it surfaces the suspicion and the human pulls the trigger.

## Templates

`notebook.md`:

```markdown
---
title:
status: active
domain:
---

## Objective

## Approach

## Open Questions
```

`research.md`:

```markdown
---
title:
status: active
---

## Findings

## Implications

## Gaps
```

`plan.md`:

```markdown
---
title:
status: active
---

## Overview

## Tasks
```

`execute.md`:

```markdown
---
title:
status: active
---

## Log
```
