---
skill: plan
version: 1.1
command: /plan
description: Decompose the approach into ordered, executable tasks grounded against available research.
---

# Plan

## Purpose
This skill translates the approach into concrete, ordered tasks. It is the first point in the process where execution is described in specific terms. If investigation is needed before tasks can be responsibly defined, a research document should be generated first. If grounding reveals conflicts with the approach, those must be resolved before the plan can advance.

## Invocation
When called, look for a `session.yml` file in the current context. If none exists, generate it by prompting the human for a stem value, then create `session.yml` as follows:

```yaml
stem: <human-provided value>
phase: plan
note: 
```

Once the session file exists, read it and confirm `phase` is `plan`. Then assess whether a `<stem>.research.md` is needed before generating tasks. If so, invoke the research skill first and incorporate its output into the Research Summary. Then generate the document template below with `status: draft`, populate the Overview, and begin generating tasks. Populate Approach Conflicts if grounding reveals issues.

## Session File
Before doing anything, locate and read `session.yml`.
- `stem`: used to locate all phase documents (`<stem>.discuss.md`, `<stem>.approach.md`, etc.)
- `phase`: must equal `plan` for this skill to proceed. If it does not, inform the human and stop.
- `note`: read as session context. Do not modify.

Never write to the session file. It is human-owned.

## Behavior
- Generate tasks based on the approach and any available research.
- Number tasks sequentially using `T1`, `T2`, etc. Numbers are permanent. Never renumber.
- Each task gets a `## T-` heading, a prose description, and a checklist. Dependencies are the first checkbox items in the list.
- Use `### ` sub-sections within a task only when necessary. Prefer splitting into multiple tasks instead.
- Nest plain bullet points under checklist items when additional detail is needed for a specific item.
- Populate Approach Conflicts if any finding conflicts with the approach. Stop generating tasks and prompt the human to return to the approach when this section has content.
- Use blockquotes at the bottom of relevant sections for human notes and adjustments.
- Do not update document status. Signal readiness to advance or flag blockers in conversation.

## Phase Relationships

### Upstream
Draws from Approach: Thesis, Structure, Assumptions.
Draws from Research (when present): Findings, Implications, Gaps.
Tasks are generated against these elements. If either upstream document changes, identify which specific tasks were built against the changed elements and flag those by number. Do not regenerate the full plan unprompted.

### Downstream
Execution draws from: task headings (T1, T2...) and their checklist items as the work to be performed.
Verification draws from: task headings and their completion state.
When tasks are added, changed, or superseded by resolution tasks, notify the human that both the Execution and Verification documents may need corresponding updates.

### Change Classification
- *Additive*: a new task is added that doesn't affect existing tasks. Notify the human that Execution and Verification may need a new entry added. No forced review of existing items.
- *Corrective*: an existing task's description or checklist changes in a way that affects how it would be executed or verified. Flag the corresponding Execution log entry and Verification check by reference.
- *Fundamental*: Approach Conflicts section is populated, indicating the approach itself is wrong or insufficient. Halt plan advancement. Escalate to the human to return to the approach before execution or verification is considered.

## Rules
- Never proceed if the session file's `phase` is not `plan`.
- Never write to the session file.
- Never advance status if Approach Conflicts contains unresolved entries.
- Task numbering is sequential and permanent. Never renumber existing tasks.
- Research Summary is only present when a `<stem>.research.md` was generated.
- Approach Conflicts entries must state: what was found, why it conflicts, and what change is recommended.
- Never delete resolved questions. Mark them checked.
- Never advance document status.

## Guidance
- Prefer multiple smaller tasks over a single complex one with sub-sections.
- Task descriptions should explain why the task exists in the context of the plan, not just restate what the checklist items say.
- Dependencies at the top of a checklist keep sequencing visible and actionable.
- If a task feels too large to describe in a short paragraph, it probably needs to be split.

## Document Template

```markdown
---
title: 
date: 
status: draft
---

## Overview

<!-- Brief statement of what this plan covers and which approach it executes against. -->

## Research Summary

<!-- Condensed synthesis of <stem>.research.md findings relevant to task generation.
     Remove this section if no research document was generated. -->

## T1 - Task Title

Description of what this task is and why it exists within the broader plan.

- [ ] Depends on: <none>
- [ ] Checklist item
- [ ] Another checklist item
  - Additional detail or context if needed

## Approach Conflicts

<!-- Populated only when grounding reveals conflicts with the approach.
     Each entry: what was found, why it conflicts, recommended change.
     When this section has content, halt planning and return to approach. -->

## Open Questions

<!-- Both LLM and human may add questions. Format: - [ ] Q1: <question> -->
```
