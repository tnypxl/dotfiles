---
name: lets
description: Stage a piece of work through one collaborative harness. Invoked as `/lets <verb> <prompt>` where verb is one of discuss, research, plan, execute. Use whenever the human says "let's discuss/research/plan/execute", references a stem's notebook.md/research.md/plan.md/execute.md, or wants to think a piece of work through in stages and capture it in durable documents — for code, writing, decisions, research, or personal planning.
---

# /lets

This skill is the dispatcher and the per-verb playbooks. It carries what you need to act. The conceptual contract — the stem, living vs. ledger, cadence, drift, voice — lives in [`./reference/WORKFLOW.md`](./reference/WORKFLOW.md); read the one section a step points you to, when it points you there, rather than all of it up front.

## Dispatch

Input is `<verb> <prompt>`. The first token is the verb; the rest is the prompt.

1. **Verb** — one of `discuss`, `research`, `plan`, `execute`. If missing or unrecognized, ask which verb is meant.
2. **Stem** — read `session.yml` at the project root for `stem` (and any `note:` context). If `session.yml` is missing, ask the human for a stem name, then create `session.yml` (`stem` + empty `note`). Find the stem folder beside it (`<index>.<stem>`); if none exists, allocate the next index (`1 +` highest existing stem index, else `1`) and create the folder.
3. **Artifact** — map verb → file: `discuss`→`notebook.md`, `research`→`research.md`, `plan`→`plan.md`, `execute`→`execute.md`. If it doesn't exist, scaffold it from the matching template below with `status: active`.
4. **Lock guard** — if the target artifact's frontmatter is `status: locked`, treat it as read-only: say so and stop. (During an execute review, if a correction sweep reaches a locked upstream artifact, surface the contradiction and ask to unlock before any change.)
5. **Domain** — if the notebook's frontmatter sets `domain: <name>`, resolve `<name>.md` against `$PWD/.agents/domains/` then `$HOME/.agents/domains/`, and read the first hit as context for shaping deliverables. Optional; skip if unset or absent.

Then run the verb's playbook, advancing one or two threads at a time (cadence: `./reference/WORKFLOW.md` § Cadence), and hand the next move back to the human.

## discuss → notebook.md

A real back-and-forth that shapes the notebook as you talk.

- Advance **Objective** and **Approach** as living sections — rewrite them clean when understanding moves, and only then.
- Surface **one or two** open questions per turn. On resolution, mark the question `[x]` with its resolution in the ledger, and fold the consequence into Objective/Approach when it changes them.
- Mid-conversation fact-checks are welcome: a narrow web lookup, or the `researcher` subagent in inline-lookup mode for anything heavier. These are ephemeral grounding that lives in the conversation; a fact earns a place when it lands in Objective/Approach.
- The **Notes** section is the human's — read it for context and leave the writing to them.

## research → research.md

Deliberate investigation, delegated to the `researcher` subagent with an already-bounded scope.

- Bound the scope first (from the notebook and the prompt); hand the subagent that scope **and the path to `./reference/WORKFLOW.md`** as its contract.
- Meter its return into `research.md` one or two threads at a time — keep Findings (neutral) separate from Implications (what they mean). Record Gaps honestly.
- If a finding conflicts with the notebook's Approach, surface it; correction is the human re-running `discuss`.

## plan → plan.md

Decomposition toward the Approach, delegated to the `planner` subagent.

- Hand the planner the committed Approach (and `research.md`, if any) **and the path to `./reference/WORKFLOW.md`**.
- One task = one outcome confirmable by a single check. Split anything that joins outcomes with "and."
- Each task carries a why-it-exists line, a checklist, and dependencies as the first item (`Depends on: <none>` when there are none).
- Meter proposed tasks into `plan.md` a few at a time; the skill owns the permanent numbers.

## execute → execute.md

The work itself, delegated to the `executor` subagent (which owns all writes to external artifacts).

- Hand the executor one task (or a tight bounded set) **and the path to `./reference/WORKFLOW.md`**. Write its report into `execute.md` as a log entry; the log is a ledger (append-only).
- Tick the task in `plan.md` when done.
- **Review each finished task for drift.** Ask: if I rewrote the notebook from scratch now, knowing this outcome, would it say something different? If the human judges it would, run the correction sweep — re-run the verb for the layer that drifted. The human judges drift; the skill surfaces the suspicion and runs the sweep once they pull the trigger. Depths and rationale: `./reference/WORKFLOW.md` § Drift and correction.

## Templates

Scaffold a missing artifact from its template; each seeds the structure its verb expects.

- `notebook.md`: [`./templates/notebook.md`](./templates/notebook.md)
- `research.md`: [`./templates/research.md`](./templates/research.md)
- `plan.md`: [`./templates/plan.md`](./templates/plan.md)
- `execute.md`: [`./templates/execute.md`](./templates/execute.md)
