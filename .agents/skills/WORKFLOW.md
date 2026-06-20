# Workflow Conventions

This document owns the conventions shared by every skill in `.agents/skills/`. Each individual SKILL.md references this file rather than restating its rules. Read it once when any phase skill is invoked, then return to the skill's own body for phase-specific behavior.

The phase chain is:

```
discover → discuss → approach → (research) → plan → execute → verify
```

`research` is invoked from within `plan` rather than being a phase unto itself.

These conventions are domain-agnostic. The workflow is used for code work, writing, decisions, team processes, personal planning, and anything else that benefits from being thought through in phases.

## Session File

The whole workflow is steered by a single `session.yml` at the project root. It is the cursor: it names the stem and phase you are currently working, plus any note. There is exactly one of these, no matter how many stems exist.

```yaml
stem: <short, filename-friendly name for the work>
phase: <one of: discover, discuss, approach, plan, execute, verify>
note: <optional free-form context the human may write>
```

- The session file is **human-owned**. No skill may write to or modify it (the one exception is bootstrap, below, which *creates* it when none exists). To switch which stem you're working on, or to advance/loop-back a phase, the human edits this file.
- `stem` names the active stem. It is the label for the work and, prefixed with the stem's index, the name of its folder (`<index>.<stem>` — see Stems and Naming).
- `phase` gates which skill can act. A skill must confirm `phase` matches its own name before doing anything. If it does not, the skill stops and tells the human to flip the phase.
- `note` is read as session context. Never overwritten.

If `session.yml` is missing when a skill is invoked, the skill prompts the human for a `stem` and creates the file with `phase` set to that skill's name. Bootstrap can also be done with `scripts/init_phase.py <phase> <stem>`, run from the project root.

## Cadence

Every phase is worked one or two threads at a time — never more. A *thread* is a single open question, a single proposed direction, a single section advanced. The human steers the whole workflow, and the human can only steer what stays small enough to hold.

What this guards against is breadth per turn, not length. The threads in a phase are not independent: resolving one changes the impact of the phase before it and the trajectory of the phase after, which shifts every other open thread. So a skill that surfaces four or five questions at once, or fills every section of its document in one pass, forces the human to weigh them all together — and being unsure about one means re-questioning the rest. Sequenced one or two at a time, each thread is resolved and allowed to settle before the next is raised, and any decision stays cheap to walk back.

- **Predict narrow, first.** The most valuable move a skill makes each turn is to predict — from what the human just said — the scope, trajectory, and direction implied, then surface only the single highest-leverage thread that sharpens it. A wrong narrow prediction is cheap to correct; a wide one entangles everything downstream. The human is simultaneously tuning what the scope and direction should be, so the prediction must stay small enough to tune.
- **One or two open questions per turn.** No phase raises more. More overloads the human and invites answers that conflict with each other.
- **Stay narrow until it stops making sense to.** Narrow is the default. Widening — more threads at once, a menu of options, broader scope — is the human's call. A skill offers breadth only when asked; it never imposes it.

The human moves the cursor (see Session File). A skill never nudges the conversation toward the next phase, and never tries to finish a phase in one sweep. It does one or two threads' worth of work, then hands back.

## Stems and Naming

Each piece of work — each *stem* — gets its own folder under the project root, named `<index>.<stem>`, where `index` is the stem's chronological number (the order the work began). A listing of the project root is therefore the chronology of the work itself:

```
project-root/
  session.yml            # the single cursor: stem + phase + note
  1.redesign-onboarding/
  2.auth-refactor/
  3.pricing-experiment/
```

Inside a stem's folder, phase documents are named `<index>.<order>.<phase>.md`, where `order` is the phase's fixed position in the chain:

| order | phase    |
|-------|----------|
| 1     | discover |
| 2     | discuss  |
| 3     | approach |
| 4     | research |
| 5     | plan     |
| 6     | execute  |
| 7     | verify   |

So stem 1's documents are `1.1.discover.md`, `1.2.discuss.md`, `1.3.approach.md`, `1.4.research.md`, `1.5.plan.md`, `1.6.execute.md`, `1.7.verify.md`. A skipped phase (most often research) simply leaves a gap — `1.5.plan.md` following `1.3.approach.md` — and the sequence still reads true. The two-level numbering means a listing sorts first by stem (the order work began) and then by phase.

**Where a skill works.** A skill reads `stem` and `phase` from the root `session.yml`, finds the matching folder (the one whose name matches `<index>.<stem>`), and reads the index off that folder's name. The `index` is never stored in `session.yml`; the folder name is its home. Because the order map is fixed, the skill can then compute any document's filename within the stem: `<index>.<order>.<phase>.md`.

**Allocating the index.** When a stem has no folder yet, its index is the next free number: `1 + the highest index prefix among existing stem folders` (or `1` when there are none). The bootstrap script does this automatically; a skill bootstrapping by hand applies the same rule, then creates the `<index>.<stem>` folder.

**One active stem, recoverable progress.** The root cursor tracks only the stem you're working now. An idle stem's progress is read from its documents — the latest phase document whose `status:` is not yet `complete` is where that stem stands. Switching back to it is just a matter of pointing `session.yml` at its stem and the right phase.

## Status

Every phase document begins with frontmatter that includes `status:`. The lifecycle is:

- `draft` — being shaped. The default on creation.
- `active` — being worked through with the human.
- `complete` — the human has decided this phase is done.

**The human advances status. No skill ever modifies status.** When a skill believes a phase is ready to advance, it says so in the conversation. The human makes the call and updates the document.

## Open Questions

Every phase document has an `Open Questions` section. Both the skill and the human may add questions. Format:

```
- [ ] Q1: <question>
- [ ] Q2: <question>
```

Numbering is sequential and permanent. When a question is resolved, mark it `[x]` and leave it in place. **Resolved questions are never deleted.** They are part of the record of how the document evolved.

A compound question is two questions. Split it.

## Human Notes

Within any section, the human may leave notes or requested adjustments as a blockquote at the bottom of that section:

```
> I want to revisit this once we hear back from finance.
```

Skills read these blockquotes as direction. Skills do not write into the blockquote space themselves.

## Cross-Phase Edits

The phase model expects the human to loop back. When something earlier needs revising mid-flow:

1. The human flips `phase:` in `session.yml` to the earlier phase.
2. The human re-invokes that earlier skill.
3. The earlier skill assesses the change (see Change Classification below) and surfaces a targeted impact note on downstream documents.
4. The human flips the phase back when ready to resume.

**No skill ever edits a document for a phase other than its own.** Even when a downstream skill notices something that ought to change upstream, it surfaces the issue and waits.

## Change Classification

When an upstream document changes mid-flow, skills classify the impact so the human can act surgically rather than redoing everything. Three levels:

- **Additive** — new context or detail added that does not contradict what's there. Notify the human that downstream documents may benefit from enrichment. No forced review.
- **Corrective** — a specific section or statement that downstream work was built against has changed. Identify which downstream sections, tasks, or checks were built on the changed element and flag them by name or number.
- **Fundamental** — the core of the upstream document is rewritten (e.g., Intent in discuss, Thesis in approach). Halt downstream work and escalate explicitly. The human confirms direction before downstream proceeds.

Each phase skill defines what counts as additive / corrective / fundamental in its own Phase Relationships section.

## Phase Documents — Common Frontmatter

Every phase document opens with:

```markdown
---
title: 
date: 
status: draft
---
```

The skill leaves `title` and `date` for the human and sets `status: draft` on creation.

## Artifact Hygiene

The phase documents (`<index>.1.discover.md`, `<index>.2.discuss.md`, `<index>.3.approach.md`, `<index>.4.research.md`, `<index>.5.plan.md`, `<index>.6.execute.md`, `<index>.7.verify.md`) are the workflow's internal bookkeeping. Anything produced *as a consequence of* working through them — code, prose, designs, configs, schemas, commit messages, PR descriptions, wiki pages, slides, anything that will be committed, shipped, sent, or otherwise outlive the session — is an external artifact.

External artifacts must contain no trace of the workflow's internal language:

- No task identifiers (`T1`, `T2`, ...) in code comments, function or variable names, file names, headings, commit messages, log lines, or anywhere else.
- No question identifiers (`Q1`, `Q2`, ...) anywhere in an external artifact.
- No references to phase documents (`<index>.5.plan.md`, `<index>.3.approach.md`, ...), phase names, or workflow concepts.
- No skill-internal vocabulary (Thesis, Synthesis, Findings, Implications, Open Questions, etc.) bleeding into prose deliverables.

The audit trail belongs in the phase documents. The work product belongs to itself.

**Why:** The phase machinery is scaffolding the human and skills use *during* the work. It is meaningful only inside this session. An artifact that leaks `// T2: validate input` or `# Resolves Q1` becomes hostage to a context its future readers don't share — maintainers won't know what `T2` was, the audit trail rots the moment the session directory is gone, and the artifact reads like generated boilerplate.

**How to apply:** When naming, commenting, structuring, or otherwise shaping anything that will leave the session, write as though the workflow does not exist. Name every function, variable, file, heading, key, and section for what it *is* in its own domain, never for the task or question that motivated it. A function named `validate_t1_input`, a config key `t2_enabled`, a comment `// Resolves Q1`, a CSS class `.approach-thesis`, or a doc heading "Synthesis" in a shipped report are all the same failure — rename them to the domain meaning (`validate_email`, `retries_enabled`, drop the comment, `.summary`, "Overview"). A simple test: if a name only makes sense to someone who has read the plan, it is wrong. The execution document is where `T1` is mentioned; the code, prose, or design it produced is where it is not.

## Bootstrap Script

Run from the project root:

```
python <path-to>/scripts/init_phase.py <phase> <stem>
```

- Creates `session.yml` at the root if it does not exist, setting `stem` and `phase`. If it exists, reads `stem` and `phase` from it and requires both to match the arguments (research is allowed while the phase is `plan`); otherwise refuses, telling the human to set the stem or flip the phase. It never modifies an existing `session.yml`.
- Finds the stem's folder (`<index>.<stem>`). If none exists, allocates the next index (next free number across existing stem folders) and creates the folder.
- Creates `<index>.<order>.<phase>.md` inside that folder from the phase's template with `status: draft`.
- Refuses to overwrite an existing phase document.

To start a second stem, point `session.yml` at the new stem (set `stem` and `phase`) before running the script. If running scripts is not available, the human can create `session.yml` by hand using the schema above and the skill will allocate the index, create the `<index>.<stem>` folder, and scaffold the document on invocation.
