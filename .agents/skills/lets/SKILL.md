---
name: lets
description: Stage a piece of work through one collaborative harness. Invoked as `/lets <verb> <prompt>` where verb is one of discuss, research, plan, execute. Use whenever the human says "let's discuss/research/plan/execute", references a stem's notebook.md/research.md/plan.md/execute.md, or wants to think a piece of work through in stages and capture it in durable documents — for code, writing, decisions, research, or personal planning.
---

# /lets

This skill is the dispatcher and the per-verb playbooks. It carries what you need to act. The conceptual contract — the stem, living vs. ledger, cadence, drift, voice — lives in [`./reference/WORKFLOW.md`](./reference/WORKFLOW.md); read the one section a step points you to, when it points you there, rather than all of it up front.

## Dispatch

Input is `<verb> <prompt>`. The first token is the verb; the rest is the prompt.

1. **Verb** — one of `discuss`, `research`, `plan`, `execute`. If missing or unrecognized, ask which verb is meant.
2. **Stem** — read `session.yml` at the project root for `stem`, any `note:` context, and `setup:` (if present; value is `domain` or `workflow`). If `session.yml` is missing, ask the human for a stem name, then create `session.yml` (`stem` + empty `note`). Find the stem folder beside it (`<index>.<stem>`); if none exists, allocate the next index (`1 +` highest existing stem index, else `1`) and create the folder.
3. **Artifact** — map verb → file: `discuss`→`notebook.md`, `research`→`research.md`, `plan`→`plan.md`, `execute`→`execute.md`. If it doesn't exist, scaffold it from the matching template below with `status: active`.
4. **Lock guard** — if the target artifact's frontmatter is `status: locked`, treat it as read-only: say so and stop. (During an execute review, if a correction sweep reaches a locked upstream artifact, surface the contradiction and ask to unlock before any change.)
5. **Setup mode** — if `setup:` is set, override the artifact target: `setup: domain` → `.agents/domains/<stem>.md`; `setup: workflow` → `.agents/workflows/<stem>.md`. Ignore any `domain:` / `workflow:` selectors from the notebook or `session.yml`. Skip step 6 and proceed to step 7. (Authoring mode semantics: `./reference/WORKFLOW.md` § Authoring mode.)
6. **Resolve context** — run `./scripts/resolve-context.sh` (relative to the skill's base directory, with the project root as the working directory; the script walks upward to find `session.yml`). Two outcomes: if it exits nonzero, it has already printed a human-readable resolution or coupling error to stderr — surface that message and stop, do not proceed to the playbook. If it exits 0, it emits `DOMAIN_NAME` / `DOMAIN_FILE` / `WORKFLOW_NAME` / `WORKFLOW_FILE` lines; read any non-empty `DOMAIN_FILE` as standards the deliverable must follow, and any non-empty `WORKFLOW_FILE` for per-verb tuning. Both are optional — empty values mean no selector, nothing to read. Precedence and coupling logic live in the script's contract and `./reference/WORKFLOW.md` § Selectors.
7. **Load the voice** — read `./reference/VOICE.md` as the governing voice for everything you produce this turn, conversational and artifact alike.

Then run the verb's playbook, advancing one or two threads at a time (cadence: `./reference/WORKFLOW.md` § Cadence), and hand the next move back to the human.

## discuss → notebook.md

A real back-and-forth that shapes the notebook as you talk.

- Advance **Objective** and **Approach** as living sections — rewrite them clean when understanding moves, and only then.
- Surface **one or two** open questions per turn. On resolution, mark the question `[x]` with its resolution in the ledger, and fold the consequence into Objective/Approach when it changes them.
- Mid-conversation fact-checks are welcome: a narrow web lookup, or the `researcher` subagent in inline-lookup mode for anything heavier. These are ephemeral grounding that lives in the conversation; a fact earns a place when it lands in Objective/Approach.
- The **Notes** section is the human's — read it for context and leave the writing to them.
- **Setup mode** (`setup:` set in `session.yml`): shape what the reference file is *for* — its purpose, scope, and document structure. The notebook sections become a design conversation about the reference being authored. Voice inversion applies: the deliverable is *about* the harness, so harness vocabulary (domain, workflow, stem, verb) is correct here — do not scrub it. (`./reference/WORKFLOW.md` § Authoring mode, § Voice.)

## research → research.md

Deliberate investigation, delegated to the `researcher` subagent with an already-bounded scope.

- Bound the scope first (from the notebook and the prompt); hand the subagent that scope **and the path to `./reference/WORKFLOW.md` and `./reference/VOICE.md`** as its contract.
- Meter its return into `research.md` one or two threads at a time — keep Findings (neutral) separate from Implications (what they mean). Record Gaps honestly.
- If a finding conflicts with the notebook's Approach, surface it; correction is the human re-running `discuss`.
- **Setup mode**: run dual-direction — first inward (scan existing files in `.agents/domains/` and `.agents/workflows/` for prior art and naming conventions), then outward (web survey of field conventions for the reference type being authored). Both feeds scope the sections for `plan`.

## plan → plan.md

Decomposition toward the Approach, delegated to the `planner` subagent.

- Hand the planner the committed Approach (and `research.md`, if any) **and the path to `./reference/WORKFLOW.md` and `./reference/VOICE.md`**.
- One task = one outcome confirmable by a single check. Split anything that joins outcomes with "and."
- Each task carries a why-it-exists line, a checklist, and dependencies as the first item (`Depends on: <none>` when there are none).
- Meter proposed tasks into `plan.md` a few at a time; the skill owns the permanent numbers.
- **Setup mode**: decompose the reference into writable sections — tasks map to headings (and their rationale) in the file being authored, not to stem execution steps.

## execute → execute.md

The work itself, delegated to the `executor` subagent (which owns all writes to external artifacts).

- Hand the executor one task (or a tight bounded set) **and the path to `./reference/WORKFLOW.md` and `./reference/VOICE.md`**. Write its report into `execute.md` as a log entry; the log is a ledger (append-only).
- Tick the task in `plan.md` when done.
- **Review each finished task for drift.** Ask: if I rewrote the notebook from scratch now, knowing this outcome, would it say something different? If the human judges it would, run the correction sweep — re-run the verb for the layer that drifted. The human judges drift; the skill surfaces the suspicion and runs the sweep once they pull the trigger. Depths and rationale: `./reference/WORKFLOW.md` § Drift and correction.
- **Setup mode**: the executor writes the reference file directly to `.agents/domains/<name>.md` or `.agents/workflows/<name>.md`. No imposed granularity — the human drives section by section. Harness vocabulary is correct in the output file (Voice inversion; see `discuss` playbook above).

## Templates

Scaffold a missing artifact from its template; each seeds the structure its verb expects.

- `notebook.md`: [`./templates/notebook.md`](./templates/notebook.md)
- `research.md`: [`./templates/research.md`](./templates/research.md)
- `plan.md`: [`./templates/plan.md`](./templates/plan.md)
- `execute.md`: [`./templates/execute.md`](./templates/execute.md)

Setup-mode scaffolds (keyed by `setup:` value; see § Authoring mode in `./reference/WORKFLOW.md`). These seed the reference file in `.agents/`, not a stem artifact.

- `setup: domain` → [`./templates/domain.md`](./templates/domain.md) — seeds `.agents/domains/<stem>.md`
- `setup: workflow` → [`./templates/workflow.md`](./templates/workflow.md) — seeds `.agents/workflows/<stem>.md`
