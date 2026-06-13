---
name: verify
description: Verify that a plan was executed correctly and that the outcome matches the original intent. Use whenever the human says "did this work", "are we done", "check the outcome", references a `<stem>.verify.md` or asks to close a session — for code, writing, decisions, team processes, personal commitments, or any domain — even when they don't name the skill. Prefer this skill over informal sign-off whenever a discuss + plan + execute chain exists; verification is the gate that prevents drift between intent and outcome.
---

# Verify

Read [`../WORKFLOW.md`](../WORKFLOW.md) before proceeding. It owns session, status, Open Questions, blockquote, and cross-phase edit conventions.

## Purpose

This skill closes the loop between execution and intent. It operates in two distinct areas: confirming the plan was executed correctly, and confirming the outcome matches what was originally described in the discussion. The second area is the required completion gate. Failures in either area surface here and route back to the plan as resolution tasks.

## Invocation

Confirm `phase: verify` in `session.yml`. If missing, bootstrap with `python ../scripts/init_phase.py verify <stem>` or prompt the human for a stem and create the session file manually.

Read `<stem>.plan.md`, `<stem>.execute.md`, and `<stem>.discuss.md` before generating anything. Generate `<stem>.verify.md` from the template below with `status: draft`. Generate verification criteria for both Plan Verification and Outcome Verification. Prompt the human to review, add their own criteria, and begin checking items off as verification proceeds.

## Behavior

- Generate Plan Verification checks mapped to tasks. Mirror the `T1`, `T2` convention where applicable.
- Generate Outcome Verification checks mapped to intent statements from the discussion.
- Cross-reference the execution log when generating Plan Verification criteria. What was logged informs what to check.
- The human may add verification criteria to either section at any time.
- Populate Failures when any check does not pass. Each failure entry must identify what failed, which area it belongs to, and map back to the offending task in the plan.
- When a failure is identified, generate a resolution task for the plan document. Resolution tasks reference their source with `- [ ] Resolves failing task: T<n>`.
- If a resolution task itself fails, generate a new task with a different approach rather than retrying the same one.
- Signal readiness to advance, or flag blockers, in conversation.

## Phase Relationships

### Upstream

Draws from Plan: task headings and checklist items (T1, T2...) for Plan Verification criteria. Draws from Execution: the log entries for context on what was actually done and any divergences. Draws from Discussion: Intent for Outcome Verification criteria. If the Plan changes due to resolution tasks, assess which Plan Verification checks are affected and add corresponding checks. Do not regenerate the full Plan Verification section.

### Downstream

Verification is the final phase. Its downstream influence is corrective rather than additive.

Failures in Plan Verification loop back to Plan: generate resolution tasks and add them to the plan document, targeting only the offending tasks. The session phase must be updated to `execute` by the human before execution resumes.

Failures in Outcome Verification that cannot be resolved by new plan tasks indicate something earlier in the chain is wrong. Assess whether the failure points to a specific Approach assumption or a scoping issue in Discussion, and escalate to that phase by name with a targeted description of what needs to change. Do not loop back blindly through all phases.

### Change Classification

- *Additive*: a new verification criterion is added by the human that passes. No cascade.
- *Corrective*: a check fails and maps to a specific plan task. Generate a targeted resolution task for that task only. Flag the corresponding plan task by number.
- *Fundamental*: Outcome Verification failures cannot be resolved within the plan. The approach or intent is wrong. Escalate explicitly to the specific upstream phase and section responsible, rather than flagging the entire process for review.

## Rules

- Outcome Verification must be fully checked before status can be set to complete. No exceptions. A passing Plan Verification with failing Outcome Verification means we executed the wrong plan correctly; the human needs to see this distinction unmistakably.
- Never advance status with open failures. A "complete" document with unchecked failures is a lie the future reader cannot fix without rerunning the whole chain.
- Failure entries must map to a specific task in the plan. An unattributed failure isn't actionable — resolution tasks can't reference it, and the loop back to plan has nothing to anchor.
- Plan Verification checks should map as closely as possible to checklist items within each task. A check that doesn't correspond to any planned work is verifying something else; either it belongs in Outcome Verification or it reveals a gap in the plan.
- Outcome Verification checks should trace back to specific statements in the Intent section of the discussion document. A check that doesn't trace is a check the human cannot retroactively trust.
- Never delete a resolved Open Question. Mark `[x]` and leave it.
- Never write to `session.yml`. Never advance document status. (See WORKFLOW.md.)

## Guidance

- Use the execution log to understand divergences before declaring a plan check as failed. A divergence that achieved the same outcome by a different means is not automatically a failure.
- A failure in Outcome Verification that cannot be resolved by a new plan task may indicate the approach needs revisiting. Escalate that explicitly rather than generating tasks indefinitely.
- Verification criteria written by the human carry the same weight as skill-generated ones.

## Example

Stem: `weekly-reviews`. Intent stated: *"reviews that surface what actually changed and pull contribution from the full team, not just the vocal half."* After execution, verify opens:

```markdown
## Plan Verification

- [x] T1: A v1 pre-read template is committed to the team wiki
- [ ] T2: At least three teams have used the template for two consecutive weeks
- [x] T3: Live agenda is being assembled from the pre-reads

## Outcome Verification

- [ ] Reviews are surfacing change, not status (traced to Intent: "surface what actually
  changed"). Check by reading two recent meeting notes and confirming the agenda items
  correspond to actual deltas, not standing categories.
- [ ] The quieter half of the team is contributing measurably more than before (traced to
  Intent: "pull contribution from the full team, not just the vocal half"). Check by
  comparing speaking-time distribution across three pre-format and three post-format meetings.

## Failures

<!-- Populated only when checks do not pass. -->
```

Note that Outcome Verification cannot be checked off until enough weeks have elapsed for the comparison to be meaningful — the skill flags this rather than checking it prematurely.

## Document Template

```markdown
---
title:
date:
status: draft
---

## Plan Verification

<!-- Checks mapped to plan tasks. Mirror T1, T2 headings where helpful. -->

- [ ] T1: <verification check>

## Outcome Verification

<!-- Checks mapped to original intent. Required completion gate. -->

- [ ] <outcome check traced to intent>

## Failures

<!-- Populated only when verification items do not pass.
     Each entry: what failed, which area (plan/outcome), offending task reference. -->

## Open Questions

<!-- Format: - [ ] Q1: <question> -->
```
