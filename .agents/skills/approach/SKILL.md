---
skill: approach
version: 1.1
command: /approach
description: Define the directional and structural means toward the intent established in discussion.
---

# Approach

## Purpose
This skill translates a well-understood intent into a directional strategy. It describes how the goal will be expressed structurally, not how it will be executed in detail. The approach is the bridge between understanding the problem and planning its solution. Implementation details do not belong here.

## Invocation
When called, look for a `session.yml` file in the current context. If none exists, generate it by prompting the human for a stem value, then create `session.yml` as follows:

```yaml
stem: <human-provided value>
phase: approach
note: 
```

Once the session file exists, read it and confirm `phase` is `approach`. Then generate the document template below with `status: draft`. Immediately generate an initial Thesis and Rationale based on available context (typically `<stem>.discuss.md`). Prompt the human to review and modify those two sections before proceeding to the remaining sections.

## Session File
Before doing anything, locate and read `session.yml`.
- `stem`: used to locate all phase documents (`<stem>.discuss.md`, `<stem>.approach.md`, etc.)
- `phase`: must equal `approach` for this skill to proceed. If it does not, inform the human and stop.
- `note`: read as session context. Do not modify.

Never write to the session file. It is human-owned.

## Behavior
- Generate Thesis and Rationale on invocation. These are starting points, not final positions.
- Wait for human confirmation or modification of Thesis and Rationale before working through Structure, Assumptions, Risks, and Open Questions.
- Both parties contribute to all sections beyond Thesis and Rationale.
- Use blockquotes at the bottom of relevant sections for human notes and adjustments.
- Do not update document status. Signal readiness to advance in conversation.

## Phase Relationships

### Upstream
Draws from Discussion: Intent, Scope, Constraints, Synthesis.
When generating Thesis and Rationale, trace them explicitly back to these elements. If the Discussion document is updated after Approach work has begun, assess which specific sections of the Approach were built against the changed elements before surfacing a targeted update recommendation.

### Downstream
Research draws from: Structure, Assumptions, Risks.
Plan draws from: Thesis, Structure, Assumptions.
When this document changes, identify which downstream sections depend on the changed elements and flag those by name. Do not trigger a full rewrite of downstream documents unprompted.

### Change Classification
- *Additive*: a new Assumption or Risk surfaced that doesn't contradict existing ones. Notify the human that Research or Plan may benefit from enrichment. No forced review.
- *Corrective*: Structure is revised, or an Assumption that downstream tasks were built against changes. Identify the specific Research scope areas or Plan tasks affected and flag them by name.
- *Fundamental*: Thesis is rewritten or the strategic direction changes substantially. Halt downstream work. Escalate explicitly. Research and Plan should not proceed until the human confirms the new direction.

## Rules
- Never proceed if the session file's `phase` is not `approach`.
- Never write to the session file.
- No implementation details. No execution steps. No specific tooling or methods unless they are architectural constraints.
- Thesis must not exceed two paragraphs.
- Never advance document status.
- Never delete resolved questions. Mark them checked.

## Guidance
- Thesis should be bold and directional. Hedging at this stage weakens everything downstream.
- Rationale should address why this approach over alternatives, not just describe the approach again.
- Assumptions should be falsifiable. If an assumption can't be tested or challenged, it's probably a constraint instead.
- Risks should be specific enough to inform decisions. Vague risk acknowledgment adds no value.
- Structure should describe shape and relationships between components, not a sequence of steps.

## Document Template

```markdown
---
title: 
date: 
status: draft
---

## Thesis

<!-- LLM-generated on invocation. Human may modify before proceeding. -->

## Rationale

<!-- LLM-generated on invocation. Human may modify before proceeding. -->

## Structure

<!-- High-level shape of the solution. Components and relationships. Directional, not prescriptive. -->

## Assumptions

<!-- What is being taken as true for this approach to hold. -->

## Risks

<!-- What could challenge or invalidate this approach. -->

## Open Questions

<!-- Both LLM and human may add questions. Format: - [ ] Q1: <question> -->
```
