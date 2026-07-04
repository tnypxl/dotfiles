# The `/lets` Workflow — Contract

The shared, conceptual contract behind `/lets`: what a stem is, what the four artifacts mean, the living-vs-ledger distinction, cadence, drift, voice. The `lets` skill carries the operational instructions and pulls the section it needs from here on demand; the subagents read this as their authority for the concepts they must honor.

This document holds *concepts and rationale*, stated once. Operational "what to do" lives in `SKILL.md`, not here.

## What the workflow is for

A small harness for thinking a piece of work through in stages, collaboratively. The human steers; the assistant predicts narrowly and waits. It produces a handful of clean markdown documents that a person or assistant can pick up later and be correctly oriented. It is domain-agnostic: code, writing, infra decisions, research, planning — anything that benefits from being thought through.

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
domain: coding        # optional; project-wide fallback when the notebook omits it
workflow: writing     # optional; project-wide fallback when the notebook omits it
```

It is human-owned. Switching work is editing one line. The `note:` field can carry usable context.

**Workspace footprint.** `/lets` writes `session.yml` and `<index>.<stem>/` folders **at the project root** — this is the intended workspace layout, not a scratch area. Pointed at an arbitrary repo, it will add these to the root; that is by design, so a stem's chronology sits beside the work it concerns.

## The four artifacts

| verb | writes | what it is |
|------|--------|------------|
| `discuss` | `notebook.md` | the durable anchor — objective and approach |
| `research` | `research.md` | deliberate investigation grounding the work |
| `plan` | `plan.md` | ordered tasks toward the approach |
| `execute` | `execute.md` | the work done, and a running record of it |

The notebook anchors the other three. Research, plan, and execution all hang off it; when it moves, they reconcile to it.

The notebook's shape:

```markdown
---
title:
status: active
domain:            # optional; a name resolved against the domain cascade
workflow:          # optional; a name resolved against the workflow cascade
---

## OBJECTIVE
What this work is for. One clear statement of the something.

## APPROACH
How the work is structured and why — the current best account, adaptive.
Rewritten clean as understanding shifts. Often short. May be empty until
there is something real to say.

## OPEN QUESTIONS
- [ ] Q1: ...
- [x] Q2: ... — resolved: ...

## NOTES        (optional)
```

**Notes** is the human's — an optional section they add by hand to keep approach- or objective-adjacent context. The skill reads it for context and leaves the writing to them.

## Living vs. ledger

Every section is one of two types, and the type follows from the section itself — evident on sight:

- **Living** (OBJECTIVE, APPROACH, and the body of research/plan): holds the current understanding. Rewrite it clean *whenever it changes*, and only then, so it always reads as the best statement of where things stand *now*. When something shifts, fold it into the prose so the section stays one coherent account.
- **Ledger** (Open Questions, the execution log): append-only and chronological, with sequential, permanent numbering. Resolved questions are marked `[x]` and kept in place. The trail of how understanding got here lives here, freeing the living prose to state only where things stand now. A compound question is two questions — split it.

## Status

Frontmatter `status:` is `active` or `locked`. The human owns it; the skill reads it and follows.

- `active` — the default on creation; the artifact is open to change.
- `locked` — frozen. A locked artifact is read-only: the skill leaves the file as is, and a correction sweep that reaches one stops and asks to unlock.

## Cadence

The work moves one or two threads at a time — at most two. A thread is a single open question, a single direction, a single section advanced.

- **Predict narrow, first.** From what the human just said, predict the scope and direction implied, then surface the single highest-leverage thread that sharpens it. A wrong narrow prediction is cheap to correct; a wide one entangles everything.
- **One or two open questions per turn.** Enough to move forward, few enough that the answers stay consistent with each other.
- **The human steers.** Advance one or two threads, then hand the next move back — the human picks the direction each turn.

Play it one possession at a time: advance the document a single increment, keep that increment clean, hand the next move back. Each pass leaves a tidy document that reads as a coherent whole.

## Drift and correction

**Drift** is one specific thing: a finished task produces evidence that contradicts an assumption an upstream artifact was built on — a premise turning out *wrong*. A hard task is just a hard task. A fresh idea is a new open question or a new stem. Drift is the case where the outcome overturns a premise already relied on.

The test, asked after a task: *if I rewrote the notebook from scratch right now, knowing what this task's outcome taught us, would it say something different?* Yes → drift.

The human pulls the trigger; the skill executes the sweep. **Correction is re-running the verb for the layer that drifted.** Drift has a depth, and the depth is the reach:

```
contradicts a plan detail   →  /lets plan      (creates 1 or more corrective tasks)
contradicts the approach    →  /lets discuss   then  /lets plan
contradicts the objective   →  /lets discuss   (and reconsider the stem)
```

Completed tasks stay as they are — they remain useful context — so correction adds new corrective tasks. First-time work and correction use the same verbs, whether building or repairing.

## Domain references

A stem may name a domain in its notebook frontmatter (`domain: coding`). The skill resolves the name against a cascade and reads the first hit as context for shaping deliverables (code style, citation format, document structure):

```
$PWD/.agents/domains/coding.md              # project override
$HOME/.agents/domains/coding.md             # the default floor
```

These references are read-only to the skill — project- and human-owned, like the notes section. A project overrides the default; the global default is the floor. The other `.agents/` dirs (`workflows/`, `documentation/`, `assets/`) follow the same cascade for whatever a domain or stem references.

## Workflow references

A stem may name a workflow in its notebook frontmatter (`workflow: writing`). A workflow is a named preset that tunes how the four verbs behave: it sets a default domain and carries one prose guidance section per verb it shapes. The skill resolves the name against the same cascade as domains:

```
$PWD/.agents/workflows/writing.md              # project override
$HOME/.agents/workflows/writing.md             # the default floor
```

A workflow file's structure is its signal: the presence of a `## discuss`, `## research`, `## plan`, or `## execute` section tells the skill that verb is shaped by this workflow; an absent section leaves that verb at its default. There is no separate `stages` list — a parallel enumeration would be a second source of truth and would drift from the sections themselves.

These files are read-only to the skill — project- and human-owned, following the same cascade convention as domains.

## Selectors, precedence, and coupling

`domain:` and `workflow:` are orthogonal, optional selectors. Either may be set without the other. They live on the notebook — the stem's anchor — and plan, research, and execute inherit them; those artifacts never carry them directly.

Both may also appear in `session.yml` as a project-wide fallback for stems that omit them. Precedence differs by selector. For `domain:`, it is three-tier: **notebook `domain:` > the selected workflow's preset `domain:` > `session.yml` `domain:`** — the notebook always wins; if the notebook names no domain, the selected workflow's preset domain applies; failing both, `session.yml`'s domain is the fallback. For `workflow:`, it remains two-tier: notebook `workflow:` > `session.yml` `workflow:`; workflows carry no third tier of their own.

A domain or workflow may declare that it requires its counterpart; when it does, the resolution script enforces the pairing deterministically, before the verb runs. The enforcement logic lives in the resolution script, not here.

## Authoring mode

`session.yml` accepts a `setup:` key to engage authoring mode:

```yaml
setup: domain      # or: workflow
```

In this mode the stem's deliverable *is* a new reference file — written to `.agents/domains/<name>.md` or `.agents/workflows/<name>.md`. The consumption selectors (`domain:` / `workflow:`) are ignored while authoring; you are building one, not using one.

Authoring reuses the same three subagents and four verbs, pointed at the reference file being written:

- **discuss** — shape what the reference is *for* and its structure.
- **research** — dual-direction survey: inward (project prior art, when any exists) then outward (field conventions via web); the flow's differentiator.
- **plan** — decompose the reference into writable sections.
- **execute** — write the file; no imposed granularity — the human drives.

## Voice

Internal vocabulary — task identifiers, phase names, control words — belongs to the workflow, and the work it produces speaks its own language. In code, configs, and generated text, name things for what they are in their own domain. A good name makes sense to someone who never read the plan.

**Exception — authoring mode.** A `setup` deliverable is *about* the harness: it exists to define stems, verbs, domains, and workflows. The executor must carry that vocabulary, not scrub it — the inversion is the rule's own documented exception.

## Subagents

- **`researcher`** — dual-mode: a narrow inline fact-check during `discuss` (stays in the conversation), or a full investigation for `/lets research` (writes `research.md`).
- **`planner`** — decomposes a committed approach into ordered tasks for `plan.md`.
- **`executor`** — does the real work on external artifacts for `/lets execute`; it owns all writes outside the stem documents.
