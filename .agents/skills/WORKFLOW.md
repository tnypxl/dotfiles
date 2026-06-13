# Workflow Conventions

This document owns the conventions shared by every skill in `.agents/skills/`. Each individual SKILL.md references this file rather than restating its rules. Read it once when any phase skill is invoked, then return to the skill's own body for phase-specific behavior.

The phase chain is:

```
discover → discuss → approach → (research) → plan → execute → verify
```

`research` is invoked from within `plan` rather than being a phase unto itself.

These conventions are domain-agnostic. The workflow is used for code work, writing, decisions, team processes, personal planning, and anything else that benefits from being thought through in phases.

## Session File

Every session is anchored by a `session.yml` file in the working directory.

```yaml
stem: <short, filename-friendly name for the work>
phase: <one of: discover, discuss, approach, plan, execute, verify>
note: <optional free-form context the human may write>
```

- The session file is **human-owned**. No skill may write to or modify it.
- `stem` locates every phase document for this session: `<stem>.discover.md`, `<stem>.discuss.md`, `<stem>.approach.md`, `<stem>.research.md`, `<stem>.plan.md`, `<stem>.execute.md`, `<stem>.verify.md`.
- `phase` gates which skill can act. A skill must confirm `phase` matches its own name before doing anything. If it does not, the skill stops and tells the human to flip the phase.
- `note` is read as session context. Never overwritten.

If `session.yml` is missing when a skill is invoked, the skill prompts the human for a `stem` and creates the file with `phase` set to that skill's name. Bootstrap can also be done with `scripts/init_phase.py <phase> <stem>`.

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

The phase documents (`<stem>.discover.md`, `<stem>.discuss.md`, `<stem>.approach.md`, `<stem>.research.md`, `<stem>.plan.md`, `<stem>.execute.md`, `<stem>.verify.md`) are the workflow's internal bookkeeping. Anything produced *as a consequence of* working through them — code, prose, designs, configs, schemas, commit messages, PR descriptions, wiki pages, slides, anything that will be committed, shipped, sent, or otherwise outlive the session — is an external artifact.

External artifacts must contain no trace of the workflow's internal language:

- No task identifiers (`T1`, `T2`, ...) in code comments, function or variable names, file names, headings, commit messages, log lines, or anywhere else.
- No question identifiers (`Q1`, `Q2`, ...) anywhere in an external artifact.
- No references to phase documents (`<stem>.plan.md`, `<stem>.approach.md`, ...), phase names, or workflow concepts.
- No skill-internal vocabulary (Thesis, Synthesis, Findings, Implications, Open Questions, etc.) bleeding into prose deliverables.

The audit trail belongs in the phase documents. The work product belongs to itself.

**Why:** The phase machinery is scaffolding the human and skills use *during* the work. It is meaningful only inside this session. An artifact that leaks `// T2: validate input` or `# Resolves Q1` becomes hostage to a context its future readers don't share — maintainers won't know what `T2` was, the audit trail rots the moment the session directory is gone, and the artifact reads like generated boilerplate.

**How to apply:** When naming, commenting, structuring, or otherwise shaping anything that will leave the session, write as though the workflow does not exist. Reference business and domain concepts, not phase identifiers. The execution document is where `T1` is mentioned; the code, prose, or design it produced is where it is not.

## Bootstrap Script

```
python scripts/init_phase.py <phase> <stem>
```

- Creates `session.yml` if it does not exist, setting `phase` and `stem`.
- If `session.yml` exists with a different `phase`, refuses to proceed and tells the human to flip the phase manually.
- Creates `<stem>.<phase>.md` from the phase's template with `status: draft`.
- Refuses to overwrite an existing `<stem>.<phase>.md`.

If running scripts is not available, the human can create `session.yml` by hand using the schema above and the skill will scaffold the document on invocation.
