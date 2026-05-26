---
skill: execute
version: 1.0
command: /execute
description: Execute the plan and maintain a chronological audit trail of actions, decisions, and outcomes.
---

# Execute

## Purpose
This skill does the work. The LLM is the primary executor. It works through the plan's tasks, ticks off completed checklist items in the plan document, and maintains a chronological audit trail in the execution document. The human provides thinking, judgment, and course corrections. The execution document is a faithful record of what actually happened, in the order it happened, including divergences. If the process loops back through earlier phases and returns to execution, the log must accurately reflect the full sequence of actions taken across all passes.

## Invocation
When called, look for a `session.yml` file in the current context. If none exists, generate it by prompting the human for a stem value, then create `session.yml` as follows:

```yaml
stem: <human-provided value>
phase: execute
note: 
```

Once the session file exists, read it and confirm `phase` is `execute`. Then read `<stem>.plan.md` in full before taking any action. Generate the execution document template below with `status: draft`. Begin working through tasks in the order that best serves the plan's dependencies. Log each action as it is taken.

## Session File
Before doing anything, locate and read `session.yml`.
- `stem`: used to locate all phase documents (`<stem>.discuss.md`, `<stem>.plan.md`, etc.)
- `phase`: must equal `execute` for this skill to proceed. If it does not, inform the human and stop.
- `note`: read as session context. Do not modify.

Never write to the session file. It is human-owned.

## Behavior
- Read the full plan before beginning. Understand task dependencies before choosing where to start.
- Execute tasks in dependency order unless the human instructs otherwise.
- After completing each task or meaningful sub-action, write a log entry in the execution document before moving to the next task.
- Tick completed checklist items in `<stem>.plan.md` as each item is finished. The plan document owns the completion record.
- If execution requires a decision not covered by the plan, make the decision, log it in the execution document with the reasoning, and continue. Surface it to the human if it affects scope or approach.
- If a divergence occurs, capture it inline within the log entry where it happened. Do not move it to a separate section.
- Use blockquotes at the bottom of relevant sections for human notes and adjustments.
- Do not update document status. Signal readiness to advance in conversation.

## Phase Relationships

### Upstream
Draws from Plan: task headings (T1, T2...) and their checklist items as the work to perform.
Draws from Approach: directional guidance used to assess whether execution decisions are aligned.
If the plan changes mid-execution (due to a corrective loop), identify which log entries are affected by the change and note the updated context inline rather than rewriting history.

### Downstream
Verification draws from: the execution log to understand what was done and why, alongside the plan's completion record.
If execution reveals something that will cause verification to fail, surface it before finishing rather than letting it become a verification failure. This allows a corrective task to be added to the plan while execution context is fresh.

### Change Classification
- *Additive*: a new task is added to the plan mid-execution. Log the new task when it is executed. No changes to prior log entries.
- *Corrective*: an existing task changes mid-execution due to a loop back through plan or approach. Add a note to the relevant prior log entry indicating what changed and why, then continue. Do not delete or rewrite the original entry.
- *Fundamental*: execution reveals that the approach is directionally wrong and the plan cannot proceed as written. Stop execution, document the finding in the current log entry, and escalate to the human to return to the approach phase.

## Rules
- Never proceed if the session file's `phase` is not `execute`.
- Never write to the session file.
- Never rewrite or delete existing log entries. The audit trail is append-only.
- Always tick plan document checkboxes as items complete. The plan owns completion, not the execution document.
- Never skip writing a log entry after completing a task or making an unplanned decision.
- Never advance document status.
- Never delete resolved questions. Mark them checked.

## Guidance
- Log entries should be concise but complete. What was done, what the outcome was, and whether it aligned with the task's goals and the approach. Not a play-by-play, not a summary so thin it loses meaning.
- A divergence noted inline is more useful than a divergence buried in a separate section. Keep it contextual.
- If a decision is made during execution that would have changed the plan if known earlier, note that explicitly. It helps the next pass.
- The execution document should be readable top-to-bottom as a coherent narrative of what happened.

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

<!-- Chronological entries. Each entry references its source task, describes what was done,
     assesses alignment with the task's goals and the approach, and captures any divergences inline.
     Entries are append-only. Never delete or rewrite a prior entry. -->

### Ex1 — T1: Brief description of action taken

What was done and how. Whether it met the task's requirements in alignment with the approach and plan.
Any divergence or unplanned decision captured here with reasoning.

## Open Questions

<!-- Both LLM and human may add questions. Format: - [ ] Q1: <question> -->
```
