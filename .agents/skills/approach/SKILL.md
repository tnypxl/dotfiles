---
name: approach
description: Define the directional and structural means toward an intent established in discussion. Use whenever the human says "what's our angle", "how should we think about this", "shape this up", references a `.approach.md` or `.discuss.md` document, or asks for strategy before tasks — for code, writing, decisions, team processes, personal planning, or any domain — even when they don't name the skill. Prefer this skill over jumping to /plan whenever the goal is understood but no directional thesis has been committed.
---

# Approach

Read [`../WORKFLOW.md`](../WORKFLOW.md) before proceeding. It owns session, cadence, status, Open Questions, blockquote, cross-phase edit, and artifact-hygiene conventions.

## Purpose

This skill translates a well-understood intent into a directional strategy. It describes how the goal will be expressed structurally, not how it will be executed in detail. The approach is the bridge between understanding the problem and planning its solution. Implementation details do not belong here.

## Invocation

Confirm `phase: approach` in `session.yml`. If missing, bootstrap with `python <path-to>/scripts/init_phase.py approach <stem>` or prompt the human for a stem and create the session file manually.

Then generate the approach document — named `<index>.3.approach.md` per WORKFLOW.md's Stems and Naming — from the template below with `status: draft`. Immediately generate an initial Thesis and Rationale based on available context (typically the discuss document, `<index>.2.discuss.md`). Prompt the human to review and modify those two sections before proceeding to the remaining ones.

## Behavior

- Generate Thesis and Rationale on invocation. These are starting points, not final positions.
- Wait for human confirmation or modification of Thesis and Rationale before working through Structure, Assumptions, Risks, and Open Questions.
- Both parties contribute to all sections beyond Thesis and Rationale.
- Signal readiness to advance in conversation. Do not modify status.

## Phase Relationships

### Upstream

Draws from Discussion: Intent, Scope, Constraints, Synthesis. When generating Thesis and Rationale, trace them explicitly back to these elements. If the Discussion document is updated after Approach work has begun, assess which specific sections of the Approach were built against the changed elements before surfacing a targeted update recommendation.

### Downstream

Research draws from Structure, Assumptions, Risks. Plan draws from Thesis, Structure, Assumptions. When this document changes, identify which downstream sections depend on the changed elements and flag those by name. Do not trigger a full rewrite of downstream documents unprompted.

### Change Classification

- *Additive*: a new Assumption or Risk is surfaced that doesn't contradict existing ones. Notify the human that Research or Plan may benefit from enrichment. No forced review.
- *Corrective*: Structure is revised, or an Assumption that downstream tasks were built against changes. Identify the specific Research scope areas or Plan tasks affected and flag them by name.
- *Fundamental*: Thesis is rewritten or the strategic direction changes substantially. Halt downstream work. Escalate explicitly. Research and Plan should not proceed until the human confirms the new direction.

## Rules

- No implementation details, no execution steps, no specific tooling or methods unless they are architectural constraints. Mixing the *how-precisely* into the *how-directionally* makes the Thesis untestable and forces Plan to inherit decisions that were never deliberated.
- Thesis must not exceed two paragraphs. A Thesis that needs more space is doing the work of Structure or Plan; the discipline of compression is what makes a Thesis directional rather than narrative.
- Never delete a resolved Open Question. Mark `[x]` and leave it. The trail of what was asked and why is part of the document.
- Never write to `session.yml`. Never advance document status. (See WORKFLOW.md.)

## Guidance

- Thesis should be bold and directional. Hedging at this stage weakens everything downstream.
- Rationale should address why this approach over alternatives, not just describe the approach again.
- Assumptions should be falsifiable. If an assumption can't be tested or challenged, it's probably a constraint instead.
- Risks should be specific enough to inform decisions. Vague risk acknowledgment adds no value.
- Structure should describe shape and relationships between components, not a sequence of steps.

## Example

Stem: `weekly-reviews`. Discuss landed on an Intent of restructuring reviews to surface change and pull broader participation. The approach document opens:

```markdown
## Thesis

Weekly reviews should be reorganized around what changed, not around who's reporting. The
current round-robin format optimizes for coverage; it should optimize for signal. The
meeting becomes a structured walk through a small set of "change artifacts" prepared async
beforehand, with the live time reserved for interpretation and decisions.

## Rationale

A round-robin gives every voice equal floor time regardless of whether there's anything new
to say, which is what produces the silence and the bloat. Routing the floor time toward
artifacts of actual change (rather than people) makes participation a function of having
something material to discuss, which the quieter half of the team will engage with more
readily than performative updates. The alternative — replacing the meeting entirely — was
considered and rejected because the team specifically values synchronous interpretation.

## Structure

- An async pre-read produced by each functional area, capturing what changed and what didn't
- A live agenda assembled from the pre-reads, ordered by decision urgency
- A short closing segment for cross-cutting questions

## Assumptions

- The team will reliably produce the async pre-reads when given a light template
- Decision urgency is a meaningful ordering criterion week to week
- Ninety minutes is enough for interpretation if reporting moves async

## Risks

- The async pre-read becomes the new bottleneck; lateness collapses the meeting
- Decision urgency degenerates into "loudest concern first"
```

Note how Thesis is directional but doesn't yet specify the template, the tool, or the cadence — those are Plan-level.

## Document Template

```markdown
---
title:
date:
status: draft
---

## Thesis

<!-- Generated on invocation. Human may modify before proceeding. Two paragraphs max. -->

## Rationale

<!-- Why this approach over alternatives. -->

## Structure

<!-- High-level shape of the solution. Components and relationships. Directional, not prescriptive. -->

## Assumptions

<!-- What is being taken as true for this approach to hold. Falsifiable. -->

## Risks

<!-- What could challenge or invalidate this approach. -->

## Open Questions

<!-- Format: - [ ] Q1: <question> -->
```
