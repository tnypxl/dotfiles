---
name: discuss
description: Clarify, shape, and sharpen intent through structured back-and-forth before any approach work begins. Use whenever the human says "let's talk through", "I want to think about", "help me figure out", references a `<stem>.discuss.md`, or arrives with a directed goal that still needs scoping — for code, writing, decisions, team processes, personal planning, or any domain — even when they don't name the skill explicitly. Prefer this skill over jumping to /approach whenever the goal is named but scope, constraints, or success criteria are still loose.
---

# Discuss

Read [`../WORKFLOW.md`](../WORKFLOW.md) before proceeding. It owns session, status, Open Questions, blockquote, and cross-phase edit conventions.

## Purpose

This skill takes a directed but under-shaped intent and develops it into a well-understood, well-scoped problem through collaborative dialogue. Nothing about how to solve the problem belongs here. Only what the problem is and what success looks like.

## Invocation

Confirm `phase: discuss` in `session.yml`. If missing, bootstrap with `python ../scripts/init_phase.py discuss <stem>` or prompt the human for a stem and create the session file manually.

Then generate `<stem>.discuss.md` from the template below with `status: draft` and prompt the human to fill in the Intent section. Once they provide it, populate an initial Synthesis reflecting early understanding, and begin asking clarifying questions via the Open Questions queue.

If a `<stem>.discover.md` exists, draw on its Candidate Intents, Surface, and Tensions as starting context for Synthesis. Do not copy them verbatim; the human's Intent supersedes whatever discovery surfaced.

## Behavior

- Maintain and progressively update Synthesis as understanding develops across the session.
- Add questions to Open Questions using the `Q1`, `Q2` convention. The human may also add questions.
- Mark resolved questions `[x]`. Never delete them.
- Signal when you believe the document is ready to advance by stating it in conversation, not by modifying status or the session file.

## Phase Relationships

### Upstream

Discover (when present) supplies Candidate Intents and early Surface/Tensions context. The human's Intent in this document is the authoritative replacement for whatever was on the discover side.

### Downstream

Approach draws directly from Intent, Scope, Constraints, and Synthesis. If any of these change after Approach work has begun, assess which sections changed and surface the impact to the human before they continue in the Approach document. Do not trigger a full Approach rewrite unprompted.

### Change Classification

- *Additive*: new context or detail added to Scope or Constraints that does not contradict what's there. Notify the human that Approach may benefit from enrichment. No forced review.
- *Corrective*: a specific Scope boundary, Constraint, or Synthesis statement changes. Identify which Approach sections were built against those elements and flag them by name.
- *Fundamental*: Intent itself is rewritten or substantially redirected. Escalate explicitly. Approach should not proceed until the human confirms direction.

## Rules

- Never modify the Intent section after the human has written it. Intent is the anchor every downstream phase traces back to; silently mutating it breaks the grounding of everything that comes after.
- Never guess, deduce, or assume beyond what the human has explicitly stated. Synthesis is a reflection of agreed understanding, not an opportunity for interpretation. Untracked inference here propagates as if it were the human's own commitment.
- Never remove a resolved Open Question. The trail of what was asked and resolved is how the document explains itself to a future reader.
- Never write to `session.yml`. Never advance document status. (See WORKFLOW.md.)

## Guidance

- Prefer sharpening existing scope over expanding it. More scope is rarely the answer at this stage.
- When multiple questions are open, prioritize those that block understanding of scope or constraints.
- One question per Q item. Compound questions obscure what's actually being asked.
- If the human's responses reveal a shift in intent, note it explicitly before updating Synthesis.

## Example

Stem: `weekly-reviews`. The human writes:

```markdown
## Intent

I want to reorganize how our team runs weekly reviews. Right now they take ninety minutes,
half the team is silent, and we leave without a clear sense of what changed week to week.

## Synthesis

The current format is producing low signal at high cost. The human wants reviews that surface
what actually changed and pull contribution from the full team, not just the vocal half.
Whether the answer is a format change, a frequency change, or replacing the meeting entirely
is open.

## Scope

### In
- The structure and cadence of weekly reviews
- Who attends and how participation works

### Out
- Performance reviews and 1:1s (separate process)
- Tooling choices for note-taking (downstream concern)

## Constraints

- Meeting can't grow past ninety minutes
- Has to stay synchronous (team is in the same timezone and values live discussion)

## Open Questions

- [ ] Q1: Is the goal "make reviews better" or "decide whether we still need them at all"?
- [ ] Q2: What would the human see in a single week's review that would tell them it had worked?
```

Q1 in particular sharpens scope — the answer changes whether the Approach is reformatting or replacing.

## Document Template

```markdown
---
title:
date:
status: draft
---

## Intent

<!-- The human writes this. The skill never modifies it. -->

## Synthesis

<!-- The skill maintains this as shared understanding develops. -->

## Scope

### In

### Out

## Constraints

<!-- Non-negotiables, known limitations, fixed conditions. -->

## Open Questions

<!-- Format: - [ ] Q1: <question> -->
```
