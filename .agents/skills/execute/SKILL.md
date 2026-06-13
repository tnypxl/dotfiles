---
name: execute
description: Execute a plan and maintain a chronological audit trail of actions, decisions, and outcomes. Use whenever the human says "let's do this", "start executing", "work through the plan", references a `<stem>.execute.md` or `<stem>.plan.md`, or asks to begin the work the plan describes — for code, writing, decisions, team processes, personal action, or any domain — even when they don't name the skill. Prefer this skill over freeform action whenever a plan document already exists.
---

# Execute

Read [`../WORKFLOW.md`](../WORKFLOW.md) before proceeding. It owns session, status, Open Questions, blockquote, and cross-phase edit conventions.

## Purpose

This skill does the work. The skill is the primary executor. It works through the plan's tasks, ticks off completed checklist items in the plan document, and maintains a chronological audit trail in the execution document. The human provides thinking, judgment, and course corrections. The execution document is a faithful record of what actually happened, in the order it happened, including divergences.

## Invocation

Confirm `phase: execute` in `session.yml`. If missing, bootstrap with `python ../scripts/init_phase.py execute <stem>` or prompt the human for a stem and create the session file manually.

Read `<stem>.plan.md` in full before taking any action. Generate `<stem>.execute.md` from the template below with `status: draft`. Begin working through tasks in the order that best serves the plan's dependencies. Log each action as it is taken.

## Behavior

- Read the full plan before beginning. Understand task dependencies before choosing where to start.
- Execute tasks in dependency order unless the human instructs otherwise.
- After completing each task or meaningful sub-action, write a log entry in the execution document before moving on.
- Tick completed checklist items in `<stem>.plan.md` as each item is finished.
- If execution requires a decision not covered by the plan, make the decision, log it with the reasoning, and continue. Surface it to the human if it affects scope or approach.
- If a divergence occurs, capture it inline within the log entry where it happened. Do not move it to a separate section.
- Signal readiness to advance in conversation.

## Phase Relationships

### Upstream

Draws from Plan: task headings (T1, T2...) and their checklist items as the work to perform. Draws from Approach: directional guidance used to assess whether execution decisions are aligned. If the plan changes mid-execution (due to a corrective loop), identify which log entries are affected by the change and note the updated context inline rather than rewriting history.

### Downstream

Verification draws from the execution log to understand what was done and why, alongside the plan's completion record. If execution reveals something that will cause verification to fail, surface it before finishing rather than letting it become a verification failure. This allows a corrective task to be added to the plan while execution context is fresh.

### Change Classification

- *Additive*: a new task is added to the plan mid-execution. Log the new task when it is executed. No changes to prior log entries.
- *Corrective*: an existing task changes mid-execution due to a loop back through plan or approach. Add a note to the relevant prior log entry indicating what changed and why, then continue. Do not delete or rewrite the original entry.
- *Fundamental*: execution reveals that the approach is directionally wrong and the plan cannot proceed as written. Stop execution, document the finding in the current log entry, and escalate to the human to return to the approach phase.

## Rules

- External artifacts produced during execution — code, prose, designs, configs, commit messages, PR descriptions, anything that will outlive the session — must contain no workflow vocabulary. No task identifiers (`T1`, `T2`...), no question identifiers (`Q1`, `Q2`...), no references to phase documents or phase names, no skill-internal terms (Thesis, Synthesis, Findings...). The execution log is where `T1` is mentioned; the artifact it produced is where it is not. See WORKFLOW.md's Artifact Hygiene section for the reasoning.
- Never rewrite or delete existing log entries. The audit trail's value is being trustworthy across corrective loops, not being tidy; an edited log entry is indistinguishable from a fabricated one.
- Always tick plan checkboxes as items complete. The plan owns completion, not the execution document; verification reads from the plan's checkbox state.
- Never skip a log entry after completing a task or making an unplanned decision. The decision the human will most want to inspect later is the one that wasn't worth logging at the time.
- Divergences belong inline in the log entry where they happened. A divergence buried in a separate section loses its causal connection to the work it diverged from.
- Never delete a resolved Open Question. Mark `[x]` and leave it.
- Never write to `session.yml`. Never advance document status. (See WORKFLOW.md.)

## Guidance

- Log entries should be concise but complete. What was done, what the outcome was, and whether it aligned with the task's goals and the approach.
- If a decision is made during execution that would have changed the plan if known earlier, note that explicitly. It helps the next pass.
- The execution document should be readable top-to-bottom as a coherent narrative of what happened.

## Example

Stem: `weekly-reviews`. T1 was "Draft the pre-read template." The log entry:

```markdown
### Ex1 — T1: Drafted v1 pre-read template

Wrote a one-page template with "what changed", "what didn't change", and "decisions wanted"
sections, each capped at five bullets. Circulated to two teammates for review.

Divergence: one teammate pushed back on capping "decisions wanted" at five bullets, arguing
that the constraint felt arbitrary and would force people to either skip real decisions or
fold unrelated decisions together. I removed the cap on that section only and noted it here
rather than changing the plan; the human can decide whether the plan's checklist should be
revised retroactively. The revised template is committed to the team wiki at
internal-wiki/teams/weekly-review-pre-read-v1.

The action met T1's intent. The cap-removal is a decision that wouldn't have changed the
plan but is worth flagging in case the "three to five bullets" framing carries elsewhere.
```

Note the divergence stays inside Ex1 with its reasoning attached, rather than moving to a "deviations" section.

## Document Template

```markdown
---
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
```
