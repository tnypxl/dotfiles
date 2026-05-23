---
skill: verify
version: 1.1
command: /verify
description: Verify that the plan was executed correctly and that the outcome matches the original intent.
---

# Verify

## Purpose
This skill closes the loop between execution and intent. It operates in two distinct areas: confirming the plan was executed correctly, and confirming the outcome matches what was originally described in the discussion. The second area is the required completion gate. Failures in either area surface here and route back to the plan as resolution tasks.

## Invocation
When called, look for a `session.yml` file in the current context. If none exists, generate it by prompting the human for a stem value, then create `session.yml` as follows:

```yaml
stem: <human-provided value>
phase: verify
note: 
```

Once the session file exists, read it and confirm `phase` is `verify`. Then read `<stem>.plan.md`, `<stem>.execute.md`, and `<stem>.discuss.md` before generating anything. Generate the document template below with `status: draft`. Generate verification criteria for both Plan Verification and Outcome Verification. Prompt the human to review, add their own criteria, and begin checking items off as verification proceeds.

## Session File
Before doing anything, locate and read `session.yml`.
- `stem`: used to locate all phase documents (`<stem>.discuss.md`, `<stem>.approach.md`, etc.)
- `phase`: must equal `verify` for this skill to proceed. If it does not, inform the human and stop.
- `note`: read as session context. Do not modify.

Never write to the session file. It is human-owned.

## Behavior
- Generate Plan Verification checks mapped to tasks. Mirror the `T1`, `T2` convention where applicable.
- Generate Outcome Verification checks mapped to intent statements from the discussion.
- Cross-reference the execution log when generating Plan Verification criteria. What was logged informs what to check.
- The human may add verification criteria to either section at any time.
- Populate Failures when any check does not pass. Each failure entry must identify what failed, which area it belongs to, and map back to the offending task in the plan.
- When a failure is identified, generate a resolution task for the plan document. Resolution tasks reference their source with `- [ ] Resolves failing task: T<n>`.
- If a resolution task itself fails, generate a new task with a different approach rather than retrying the same one.
- Use blockquotes at the bottom of relevant sections for human notes and adjustments.
- Do not update document status. Signal readiness to advance or flag blockers in conversation.

## Phase Relationships

### Upstream
Draws from Plan: task headings and checklist items (T1, T2...) for Plan Verification criteria.
Draws from Execution: the log entries for context on what was actually done and any divergences that occurred.
Draws from Discussion: Intent for Outcome Verification criteria.
If the Plan changes due to resolution tasks, assess which Plan Verification checks are affected and add corresponding checks. Do not regenerate the full Plan Verification section.

### Downstream
Verification is the final phase. Its downstream influence is corrective rather than additive.

Failures in Plan Verification loop back to Plan: generate resolution tasks and add them to the plan document, targeting only the offending tasks. The session phase must be updated to `execute` by the human before execution resumes.

Failures in Outcome Verification that cannot be resolved by new plan tasks indicate something earlier in the chain is wrong. Assess whether the failure points to a specific Approach assumption or a scoping issue in Discussion, and escalate to that phase by name with a targeted description of what needs to change. Do not loop back blindly through all phases.

### Change Classification
- *Additive*: a new verification criterion is added by the human that passes. No cascade.
- *Corrective*: a check fails and maps to a specific plan task. Generate a targeted resolution task for that task only. Flag the corresponding plan task by number.
- *Fundamental*: Outcome Verification failures cannot be resolved within the plan. The approach or intent is wrong. Escalate explicitly to the specific upstream phase and section responsible, rather than flagging the entire process for review.

## Rules
- Never proceed if the session file's `phase` is not `verify`.
- Never write to the session file.
- Outcome Verification must be fully checked before status can be set to complete. No exceptions.
- Never advance status with open failures.
- Never delete resolved questions. Mark them checked.
- Failures entries must map to a specific task in the plan. Unattributed failures are not actionable.
- Never advance document status.

## Guidance
- Plan Verification checks should map as closely as possible to the checklist items within each task.
- Outcome Verification checks should trace back to specific statements in the Intent section of the discussion document.
- Use the execution log to understand divergences before declaring a plan check as failed. A divergence that achieved the same outcome by a different means is not automatically a failure.
- A failure in Outcome Verification that cannot be resolved by a new plan task may indicate the approach needs revisiting. Escalate that explicitly rather than generating tasks indefinitely.
- Verification criteria written by the human carry the same weight as LLM-generated ones.

## Document Template

```markdown
---
title: 
date: 
status: draft
---

## Plan Verification

<!-- Checks mapped to plan tasks. Confirms correct execution.
     Cross-reference the execution log for context on divergences.
     Mirror T1, T2 headings from the plan where helpful. -->

- [ ] T1: <verification check>
- [ ] T2: <verification check>

## Outcome Verification

<!-- Checks mapped to original intent. This is the required completion gate.
     All items must be checked before the phase can be marked complete. -->

- [ ] <outcome check traced to intent>

## Failures

<!-- Populated only when verification items do not pass.
     Each entry: what failed, which area (plan/outcome), offending task reference.
     Resolution tasks generated here get added back to the plan document. -->

## Open Questions

<!-- Both LLM and human may add questions. Format: - [ ] Q1: <question> -->
```
