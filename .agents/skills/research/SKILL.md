---
name: research
description: Investigate and ground an approach against real material before tasks are defined. Use whenever the human says "I need to look into", "find out", "check what's out there", references a `<stem>.research.md`, or starts /plan and realizes tasks would be guesses without grounding — for code, writing, decisions, team processes, market scans, or any domain — even when they don't name the skill. This skill is normally invoked from within the plan phase, not as a standalone request.
---

# Research

Read [`../WORKFLOW.md`](../WORKFLOW.md) before proceeding. It owns session, status, Open Questions, blockquote, and cross-phase edit conventions.

## Purpose

This skill is generated during the plan phase when the approach requires grounding against real material before tasks can be responsibly defined. Its findings feed directly into the plan's Research Summary and may surface conflicts that require returning to the approach.

## Invocation

Research is invoked from within the plan phase. Confirm `phase: plan` in `session.yml`. If the session phase is not `plan`, stop and tell the human. (Bootstrap, if needed: `python ../scripts/init_phase.py research <stem>` — note this does not change the session phase, which stays `plan`.)

Generate `<stem>.research.md` from the template below with `status: draft`. Prompt the human to define or confirm the scope of investigation if it is not already clear from context. Begin investigation and populate Findings progressively. Complete Implications and Gaps before signaling readiness to return to the plan phase.

## Behavior

- Scope the investigation before conducting it. Do not research broadly and scope later.
- Populate Findings as neutral observations. No interpretation belongs there.
- Populate Implications as a distinct step after Findings are established.
- If Implications reveal conflicts with the approach, flag them prominently before the human proceeds to planning.
- Signal readiness to advance, or flag blockers, in conversation.

## Phase Relationships

### Upstream

Draws from Approach: Structure, Assumptions, Risks. The investigation scope should be anchored to these elements. If the Approach document changes after research has begun, assess whether the changed elements affect what was investigated or what conclusions were drawn, and surface only those affected Findings or Implications for revision.

### Downstream

Plan draws from Findings, Implications, Gaps. Specifically, Implications feed the Research Summary in the plan, and any Implications that conflict with the Approach feed the Approach Conflicts section. When this document changes, identify which Plan sections are affected rather than flagging the entire plan for review.

### Change Classification

- *Additive*: a new Finding is added that is consistent with existing Implications. Notify the human that Plan's Research Summary may benefit from a minor update. No forced review.
- *Corrective*: an Implication changes in a way that affects specific Plan tasks. Identify those tasks by number and flag them for targeted review.
- *Fundamental*: Findings invalidate a core Assumption from the Approach, or the investigation scope was wrong in a way that undermines the Implications entirely. Escalate before proceeding to Plan. The Approach may need to be revisited first.

## Rules

- Findings must be factual and neutral. Interpretation belongs in Implications. Mixing the two collapses the only mechanism that lets the human see whether your conclusions actually follow from what you observed.
- Gaps must be declared honestly. Do not omit areas that could not be determined. A buried Gap is the failure mode that turns into an Approach Conflict later, after Plan has already committed.
- Never conflate Findings and Implications. They are structurally and semantically separate; the document loses its grounding function if a reader can't tell which is which.
- Never delete a resolved Open Question. Mark `[x]` and leave it.
- Never write to `session.yml`. Never advance document status. (See WORKFLOW.md.)

## Guidance

- A tightly scoped investigation produces clearer implications. Resist the urge to expand scope mid-investigation.
- If a Gap is large enough to invalidate the approach, escalate it before proceeding. Do not bury it.
- Implications should connect directly to decisions in the plan. If an implication doesn't inform a task or conflict, question whether it belongs.

## Example

Stem: `weekly-reviews`. The approach assumes peer teams have workable patterns for change-driven reviews. The plan needs grounding before drafting the pre-read template, so research is invoked:

```markdown
## Scope

Investigate how three to five peer or adjacent teams structure their recurring synthesis
meetings, specifically how they decide what gets surfaced and how participation is distributed.
Bounded to interviews and shared docs; not a literature review.

## Findings

- Two of four peer teams interviewed use an async pre-read; one uses a live whiteboard; one
  uses a rotating presenter format.
- Both async-pre-read teams report that the bottleneck is template fatigue, not late submissions.
- Both teams that surface "change" rather than "status" use a deliberate "what didn't change"
  prompt to avoid false signal.

## Implications

- The async pre-read pattern is workable but template design is the highest-risk decision.
- Including a "what didn't change" prompt is cheap and likely valuable; the approach should
  treat this as a structural element, not an optional one.
- The rotating presenter and live whiteboard formats are not contradictory data, but they
  suggest the team should explicitly try the pre-read for a bounded number of weeks before
  treating it as settled.

## Gaps

- No peer team interviewed has a team size matching ours; the dynamics may not transfer.
- Did not investigate how teams handle weeks when there is genuinely no meaningful change.
```

The third Implication might escalate as a Corrective change to Approach (the Structure section should incorporate "what didn't change"). The second Gap might become an Open Question that returns to Discuss if it turns out to matter.

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

<!-- Factual, neutral observations. No interpretation. -->

## Implications

<!-- What the findings mean for the approach and plan. Separate from Findings. -->

## Gaps

<!-- What could not be determined. -->

## Open Questions

<!-- Format: - [ ] Q1: <question> -->
```
