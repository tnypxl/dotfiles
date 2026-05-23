---
skill: discuss
version: 1.1
command: /discuss
description: Clarify, shape, and sharpen intent through structured back-and-forth before approach work begins.
---

# Discuss

## Purpose
This skill initiates the process. Its job is to take a raw statement of intent from the human and develop it into a well-understood, well-scoped problem through collaborative dialogue. Nothing about how to solve the problem belongs here. Only what the problem is and what success looks like.

## Invocation
When called, look for a `session.yml` file in the current context. If none exists, prompt the human for a stem value (a short, filename-friendly description of the work), then generate `session.yml` as follows:

```yaml
stem: <human-provided value>
phase: discuss
note: 
```

Once the session file exists, read it and confirm `phase` is `discuss`. Then generate the document template below with `status: draft` and prompt the human to fill in the Intent section. Once the human provides their intent, set `status: active`, populate an initial Synthesis reflecting early understanding, and begin asking clarifying questions via the Open Questions queue.

## Session File
Before doing anything, locate and read `session.yml`.
- `stem`: used to locate all phase documents (`<stem>.discuss.md`, `<stem>.approach.md`, etc.)
- `phase`: must equal `discuss` for this skill to proceed. If it does not, inform the human and stop.
- `note`: read as session context. Do not modify.

Never write to the session file. It is human-owned.

## Behavior
- Maintain and progressively update Synthesis as understanding develops across the session.
- Add questions to Open Questions using the `Q1`, `Q2` convention. The human may also add questions.
- Mark resolved questions with `[x]`. Never delete them.
- Use blockquotes at the bottom of relevant sections as the canonical space for human notes and requested adjustments.
- Do not update document status. That is the human's responsibility.
- Signal when you believe the document is ready to advance by stating it explicitly in the conversation, not by modifying the status or the session file.

## Phase Relationships

### Upstream
Discussion is the first phase. It has no upstream dependencies.

### Downstream
Approach draws directly from: Intent, Scope, Constraints, and Synthesis.
If any of these change after Approach work has begun, assess which of those sections changed and surface the impact to the human before they continue in the Approach document. Do not trigger a full Approach rewrite unprompted.

### Change Classification
- *Additive*: new context or detail added to Scope or Constraints that doesn't contradict what's there. Notify the human that Approach may benefit from enrichment. No forced review.
- *Corrective*: a specific Scope boundary, Constraint, or Synthesis statement changes. Identify which Approach sections were built against those elements and flag them by name.
- *Fundamental*: Intent itself is rewritten or substantially redirected. Escalate explicitly. Approach should not proceed until the human confirms direction.

## Rules
- Never proceed if the session file's `phase` is not `discuss`.
- Never write to the session file.
- Never modify the Intent section after the human has written it.
- Never guess, deduce, or assume beyond what the human has explicitly stated.
- Never advance document status.
- Never remove a resolved question. Mark it checked and leave it.
- Synthesis is a reflection of agreed understanding, not an opportunity for interpretation or extrapolation.

## Guidance
- Prefer sharpening existing scope over expanding it. More scope is rarely the answer at this stage.
- When multiple questions are open, prioritize resolving those that block understanding of scope or constraints.
- One question per Q item. Compound questions obscure what's actually being asked.
- If the human's responses reveal a shift in intent, note it explicitly before updating Synthesis.

## Document Template

```markdown
---
title: 
date: 
status: draft
---

## Intent

<!-- Fill in what you want to accomplish. This section is yours and will not be modified. -->

## Synthesis

<!-- LLM-maintained. Updated progressively as shared understanding develops. -->

## Scope

### In

### Out

## Constraints

<!-- Non-negotiables, known limitations, fixed conditions. -->

## Open Questions

<!-- Both LLM and human may add questions. Format: - [ ] Q1: <question> -->
```
