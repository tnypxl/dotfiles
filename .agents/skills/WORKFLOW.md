# The `/lets` Workflow

A small harness for thinking a piece of work through in stages, collaboratively. You steer; the assistant predicts narrowly and waits. It produces a handful of clean markdown documents that a person — or another assistant — can pick up later and be correctly oriented. It is domain-agnostic: code, writing, infra decisions, research, planning, anything that benefits from being thought through.

This document is the shared contract. The `lets` skill references it; read it once when `/lets` is invoked, then return to the skill for the verb's behavior.

## One command

```
/lets [discuss | research | plan | execute] <prompt>
```

The verb is the action. It selects the behavior and the one artifact that behavior writes. There is no phase to be "in" and no gate to flip — you just say what to do next.

## The stem

A **stem** is one cluster of thinking, planning, and execution toward one something. Each stem is a folder at the project root, named `<index>.<stem>` (index = the order the work began). A root listing is the chronology of the work.

```
project-root/
  session.yml              # active stem (+ optional note)
  1.redesign-onboarding/
    notebook.md  research.md  plan.md  execute.md
  2.auth-refactor/
  .agents/
    domains/  workflows/  documentation/  assets/    # shared references
```

`session.yml` is the cursor and holds one thing — which stem is active:

```yaml
stem: redesign-onboarding
note: optional free-form context
```

It is human-owned. Switching work is editing one line. `/lets` reads the stem, finds the folder beside `session.yml`, and writes the artifact the verb names. On first use for a new stem it scaffolds `session.yml`, the folder, and the artifact — allocating the next index (`1 +` the highest existing stem index, or `1`).

## The four artifacts

| verb | writes | what it is |
|------|--------|------------|
| `discuss` | `notebook.md` | the durable anchor — objective and approach |
| `research` | `research.md` | deliberate investigation grounding the work |
| `plan` | `plan.md` | ordered tasks toward the approach |
| `execute` | `execute.md` | the work done, and a running record of it |

The notebook anchors the other three. Research, plan, and execution all hang off it; when it moves, they reconcile to it.

## The notebook

```markdown
---
title:
status: active
domain:            # optional; a name resolved against the domain cascade
---

## Objective
What this work is for. One clear statement of the something.

## Approach
How the work is structured and why — the current best account, adaptive.
Rewritten clean as understanding shifts. Often short. May be empty until
there is something real to say.

## Open Questions
- [ ] Q1: ...
- [x] Q2: ... — resolved: ...

## Notes        (optional, yours)
```

- **Objective** and **Approach** are *living* (see below).
- **Open Questions** is a *ledger*.
- **Notes** is yours: an optional section you add by hand to keep approach- or objective-adjacent context. The skill reads it; the skill never writes, fills, or prunes it.

## Living vs. ledger

Every section is one of two types, and the type is fixed by the section, not by a rule to remember:

- **Living** (Objective, Approach, and the body of research/plan): holds the current understanding, rewritten clean *whenever it changes* — left untouched when a turn doesn't move it — so it always reads as the best statement of where things stand *now*. Not append-only, and not regenerated for its own sake. When something shifts, rewrite the section to integrate it; do not bolt on a "shift noted" paragraph.
- **Ledger** (Open Questions, the execution record): append-only and chronological. Numbering is sequential and permanent. Resolved questions are marked `[x]` and left in place, never deleted. The trail of how understanding got here lives here, not stamped into the living prose. A compound question is two questions — split it.

## Status

Frontmatter `status:` is `active` or `locked`. You set it; the skill never does.

- `active` — the default on creation; the artifact is open to change.
- `locked` — frozen. The skill refuses to write a locked artifact, and a correction sweep that reaches a locked artifact stops and asks rather than rewriting it.

## Cadence

The work moves one or two threads at a time — never more. A thread is a single open question, a single direction, a single section advanced.

- **Predict narrow, first.** From what you just said, predict the scope and direction implied, then surface only the single highest-leverage thread that sharpens it. A wrong narrow prediction is cheap to correct; a wide one entangles everything.
- **One or two open questions per turn.** No more. Overloading invites answers that conflict with each other.
- **You steer.** The skill never auto-advances, never finishes a stage in one sweep, never picks the direction for you. It does one or two threads' work and hands back.

The instinct to guard against: trying to win the game in one possession. The skill advances the document one increment, then hands the next move back. Build progressively; keep it clean as you go — neither a finished dump nor every increment left as sediment.

## The verbs

- **`discuss`** — a real back-and-forth, not a document-filling exercise. As conclusions and decisions are reached, the Objective and Approach are updated to match; resolved questions move to the ledger. Narrow web lookups are welcome mid-conversation to check a fact — these are *ephemeral grounding* and write nothing to `research.md`. A fact persists only if it lands in the Objective or Approach.
- **`research`** — deliberate investigation, delegated to the `researcher` subagent, producing `research.md`. This is the only thing that writes that file.
- **`plan`** — decomposition into ordered tasks toward the approach, delegated to the `planner` subagent, producing `plan.md`.
- **`execute`** — the work itself, delegated to the `executor` subagent, recorded in `execute.md`. Each finished task is reviewed; that review is where correction begins.

## Drift and correction

**Drift** is when a finished task produces evidence that contradicts an assumption an upstream artifact was built on — a premise becoming *wrong*. Not difficulty (a task being hard is just the task). Not opportunity (a new idea is a new open question or a new stem, not drift).

The test, asked after a task: *if I rewrote the notebook from scratch right now, knowing what this task just taught me, would it say something different?* Yes → drift.

You pull the trigger — the skill executes the sweep, it does not decide on its own that the approach drifted. **Correction is re-running the verb for the layer that drifted.** Drift has a depth, and the depth is the reach:

```
contradicts a plan detail   →  /lets plan      (re-settle tasks)
contradicts the approach    →  /lets discuss   then  /lets plan
contradicts the objective   →  /lets discuss   (and reconsider the stem)
```

No phase flip, no reconcile skill, no taxonomy. First-time work and correction use the same commands.

## Domain references

A stem may name a domain in its notebook frontmatter (`domain: coding`). The skill resolves the name against a cascade and reads the first hit as context for shaping deliverables (code style, citation format, document structure):

```
$PWD/.agents/domains/coding.md          # project override
~/dotfiles/.agents/domains/coding.md    # the default floor
```

These references are read-only to the skill — project- and human-owned, like Notes. A project overrides the default; the dotfiles default is the floor. The other `.agents/` dirs (`workflows/`, `documentation/`, `assets/`) follow the same cascade for whatever a domain or stem references.

## Voice

The documents are written for you to read — now, and on return weeks later. They describe **the work**, not the collaborators: no "the human"/"the assistant" as subjects; state what is true and let it stand. They carry **no harness vocabulary** — no `Q`/task identifiers used as narration, phase names, or control words ("drift," "locked," "ledger") in the prose; that machinery is how the skill reasons, not content. And nothing the work produces — code, prose, configs — carries any of it either; name everything for what it is in its own domain (`validate_email`, never `validate_t1_input`). A simple test: if a name only makes sense to someone who read the plan, it is wrong.

## Subagents

- **`researcher`** — dual-mode: a narrow inline fact-check during `discuss` (writes nothing), or a full investigation for `/lets research` (writes `research.md`).
- **`planner`** — decomposes a committed approach into ordered tasks for `plan.md`.
- **`executor`** — does the real work on external artifacts for `/lets execute`; the only subagent that writes outside the stem documents.
