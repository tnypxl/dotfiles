---
skill: research
version: 1.1
command: /research
description: Investigate and ground the approach against code, topics, or subject matter before planning.
---

# Research

## Purpose
This skill is generated during the plan phase when the approach requires grounding against real material before tasks can be responsibly defined. Its findings feed directly into the plan's Research Summary and may surface conflicts that require returning to the approach. It is not a phase unto itself but may be promoted to one in future versions of this process.

## Invocation
When called, look for a `session.yml` file in the current context. If none exists, generate it by prompting the human for a stem value, then create `session.yml` as follows:

```yaml
stem: <human-provided value>
phase: plan
note: 
```

Once the session file exists, read it and confirm `phase` is `plan`. Then generate the document template below with `status: draft`. Prompt the human to define or confirm the scope of investigation if it is not already clear from context. Begin investigation and populate Findings progressively. Complete Implications and Gaps before signaling readiness for the plan phase.

## Session File
Before doing anything, locate and read `session.yml`.
- `stem`: used to locate all phase documents (`<stem>.discuss.md`, `<stem>.approach.md`, etc.)
- `phase`: must equal `plan` for this skill to proceed. Research is invoked from within the plan phase. If the session phase is not `plan`, inform the human and stop.
- `note`: read as session context. Do not modify.

Never write to the session file. It is human-owned.

## Behavior
- Scope the investigation before conducting it. Do not research broadly and scope later.
- Populate Findings as neutral observations. No interpretation belongs there.
- Populate Implications as a distinct step after Findings are established.
- If Implications reveal conflicts with the approach, flag them prominently before the human proceeds to planning.
- Use blockquotes at the bottom of relevant sections for human notes and adjustments.
- Do not update document status. Signal readiness to advance or flag blockers in conversation.

## Phase Relationships

### Upstream
Draws from Approach: Structure, Assumptions, Risks.
The investigation scope should be anchored to these elements. If the Approach document changes after research has begun, assess whether the changed elements affect what was investigated or what conclusions were drawn, and surface only those affected Findings or Implications for revision.

### Downstream
Plan draws from: Findings, Implications, Gaps.
Specifically, Implications feed the Research Summary in the plan, and any Implications that conflict with the Approach feed the Approach Conflicts section. When this document changes, identify which Plan sections are affected rather than flagging the entire plan for review.

### Change Classification
- *Additive*: a new Finding is added that is consistent with existing Implications. Notify the human that Plan's Research Summary may benefit from a minor update. No forced review.
- *Corrective*: an Implication changes in a way that affects specific Plan tasks. Identify those tasks by number and flag them for targeted review.
- *Fundamental*: Findings invalidate a core Assumption from the Approach, or the investigation scope was wrong in a way that undermines the Implications entirely. Escalate before proceeding to Plan. The Approach may need to be revisited first.

## Rules
- Never proceed if the session file's `phase` is not `plan`.
- Never write to the session file.
- Findings must be factual and neutral. Interpretation belongs in Implications, not Findings.
- Gaps must be declared honestly. Do not omit areas that could not be determined.
- Never conflate Findings and Implications. They are structurally and semantically separate.
- Never advance document status.
- Never delete resolved questions. Mark them checked.

## Guidance
- A tightly scoped investigation produces clearer implications. Resist the urge to expand scope mid-investigation.
- If a Gap is large enough to invalidate the approach, escalate it before proceeding. Do not bury it.
- Implications should connect directly to decisions in the plan. If an implication doesn't inform a task or conflict, question whether it belongs.

## Document Template

```markdown
---
title: 
date: 
status: draft
---

## Scope

<!-- What is being investigated and why. Bounded before investigation begins. -->

## Findings

<!-- Factual, neutral observations from the investigation. No interpretation here. -->

## Implications

<!-- What the findings mean for the approach and plan. Clearly separated from Findings. -->

## Gaps

<!-- What could not be determined. What remains unknown or out of reach. -->

## Open Questions

<!-- Both LLM and human may add questions. Format: - [ ] Q1: <question> -->
```
