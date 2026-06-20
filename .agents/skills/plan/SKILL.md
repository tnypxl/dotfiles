---
name: plan
description: Decompose an approach into ordered, executable tasks grounded against available research. Use whenever the human says "plan this", "break this down", "what are the steps", references a `.plan.md` or `.approach.md` document, or asks to turn a strategy into concrete work — for code, writing, decisions, team processes, personal planning, or any domain — even when they don't name the skill. Prefer this skill over jumping to /execute whenever the approach is committed but tasks have not been ordered and scoped.
---

# Plan

Read [`../WORKFLOW.md`](../WORKFLOW.md) before proceeding. It owns session, cadence, status, Open Questions, blockquote, cross-phase edit, and artifact-hygiene conventions.

## Purpose

This skill translates the approach into concrete, ordered tasks. It is the first point in the process where execution is described in specific terms. If investigation is needed before tasks can be responsibly defined, a research document should be generated first. If grounding reveals conflicts with the approach, those must be resolved before the plan can advance.

## Invocation

Confirm `phase: plan` in `session.yml`. If missing, bootstrap with `python <path-to>/scripts/init_phase.py plan <stem>` or prompt the human for a stem and create the session file manually.

Assess whether a research document (`<index>.4.research.md`) is needed before generating tasks. If so, invoke the research skill first and incorporate its output into the Research Summary. Then generate the plan document — named `<index>.5.plan.md` per WORKFLOW.md's Stems and Naming — from the template below with `status: draft`, populate the Overview, and begin generating tasks. Populate Approach Conflicts if grounding reveals issues.

## Behavior

- Generate tasks based on the approach and any available research.
- Number tasks sequentially using `T1`, `T2`, etc.
- Each task gets a `## T-` heading, a prose description, and a checklist. Dependencies are the first checkbox items in the list.
- Size each task to one outcome confirmable by a single verification check. When confirming the task is done would take more than one independent check, the task is really several — split it. (The verify phase maps a check per task; this keeps that mapping one-to-one.)
- Use `### ` sub-sections within a task only when necessary. Prefer splitting into multiple tasks instead.
- Nest plain bullet points under checklist items when additional detail is needed for a specific item.
- Populate Approach Conflicts if any finding conflicts with the approach. Stop generating tasks and prompt the human to return to the approach when this section has content.
- Signal readiness to advance, or flag blockers, in conversation.

## Phase Relationships

### Upstream

Draws from Approach: Thesis, Structure, Assumptions. Draws from Research (when present): Findings, Implications, Gaps. Tasks are generated against these elements. If either upstream document changes, identify which specific tasks were built against the changed elements and flag those by number. Do not regenerate the full plan unprompted.

### Downstream

Execution draws from task headings (T1, T2...) and their checklist items as the work to be performed. Verification draws from task headings and their completion state. When tasks are added, changed, or superseded by resolution tasks, notify the human that both the Execution and Verification documents may need corresponding updates.

### Change Classification

- *Additive*: a new task is added that doesn't affect existing tasks. Notify the human that Execution and Verification may need a new entry added. No forced review of existing items.
- *Corrective*: an existing task's description or checklist changes in a way that affects how it would be executed or verified. Flag the corresponding Execution log entry and Verification check by reference.
- *Fundamental*: Approach Conflicts section is populated, indicating the approach itself is wrong or insufficient. Halt plan advancement. Escalate to the human to return to the approach before execution or verification is considered.

## Rules

- Task numbering is sequential and permanent. Never renumber. Execution log entries and verification checks reference task numbers by name; renumbering silently invalidates every downstream pointer.
- Task identifiers (`T1`, `T2`...) live only inside this plan document. They are pointers for the execution and verification phases, not labels for the work itself. When a task describes producing something external — code, prose, configs, a deliverable of any kind — write the task so its identifier never travels into that artifact's names, comments, or structure. The artifact is named for its domain; the `T1` stays here. (See WORKFLOW.md's Artifact Hygiene.)
- Never advance status if Approach Conflicts contains unresolved entries. The plan is structurally untrustworthy until those resolve; a downstream phase acting on it will compound the conflict.
- Research Summary is present only when a research document (`<index>.4.research.md`) was generated. An empty Research Summary tells a future reader something was missed; omitting the section tells them nothing was needed.
- Approach Conflicts entries must state what was found, why it conflicts, and what change is recommended. An unattributed conflict is not actionable.
- Never delete a resolved Open Question. Mark `[x]` and leave it.
- Never write to `session.yml`. Never advance document status. (See WORKFLOW.md.)

## Guidance

- Prefer multiple smaller tasks over a single complex one with sub-sections.
- Task descriptions should explain why the task exists in the context of the plan, not just restate what the checklist items say.
- Dependencies at the top of a checklist keep sequencing visible and actionable.
- Two concrete signs a task is oversized: its description joins distinct outcomes with an "and" ("build X and migrate Y"), or a checklist item is itself a deliverable with its own acceptance bar rather than a step toward the task's single outcome. Either one means split it.
- Splitting an oversized task usually exposes sequencing that was hidden inside it. Make that explicit as `Depends on:` edges between the resulting tasks.

## Example

Stem: `weekly-reviews`. The approach committed to async pre-read + live interpretation. One early task:

```markdown
## T1 - Draft the pre-read template

This task produces the artifact that the rest of the approach depends on. Research flagged
template design as the highest-risk decision; we want the first version in the team's hands
quickly so we can iterate based on real submissions rather than imagined ones.

- [ ] Depends on: <none>
- [ ] Draft a one-page template with sections for "what changed", "what didn't change", and "decisions wanted"
  - Each section should be answerable in three to five bullets
- [ ] Circulate the draft to two team members for a sanity pass
- [ ] Revise based on their feedback and commit the v1 template to the team wiki
```

Note that "Depends on: <none>" is explicit even when there are no dependencies — it confirms the absence rather than leaving the reader to infer it.

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

<!-- Condensed synthesis of the research document's (<index>.4.research.md) findings relevant to task generation.
     Remove this section if no research document was generated. -->

## T1 - Task Title

Description of what this task is and why it exists within the broader plan.

- [ ] Depends on: <none>
- [ ] Checklist item
- [ ] Another checklist item

## Approach Conflicts

<!-- Populated only when grounding reveals conflicts with the approach.
     Each entry: what was found, why it conflicts, recommended change.
     When this section has content, halt planning and return to approach. -->

## Open Questions

<!-- Format: - [ ] Q1: <question> -->
```
