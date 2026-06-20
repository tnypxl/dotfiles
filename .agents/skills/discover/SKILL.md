---
name: discover
description: Surface a problem space when intent is not yet clear enough to discuss. Use whenever the human voices a vague itch, a restlessness, competing pulls, or a "something feels off but I can't name it" — for code, writing, decisions, relationships, work, or any domain — even when they don't ask for "discovery" by name. Prefer this skill over jumping straight to /discuss whenever the human's opening framing is exploratory rather than directed.
---

# Discover

Read [`../WORKFLOW.md`](../WORKFLOW.md) before proceeding. It owns session, cadence, status, Open Questions, blockquote, cross-phase edit, and artifact-hygiene conventions.

## Purpose

This skill is the first phase. Its job is to take an inchoate concern — something the human hasn't yet shaped into a clear goal — and surface enough of the underlying problem space that the human can choose a direction to bring into `/discuss`. Nothing here commits to a goal. The output is a map, not a route.

## Invocation

Confirm `phase: discover` in `session.yml` (see WORKFLOW.md). If missing, bootstrap with `python <path-to>/scripts/init_phase.py discover <stem>` or prompt the human for a stem and create the session file manually.

Then generate the discover document — named `<index>.1.discover.md` per WORKFLOW.md's Stems and Naming — from the template below with `status: draft`. Begin by inviting the human to talk loosely about what's on their mind. Reflect back what you hear into Surface; let Tensions and Candidate Intents emerge as the conversation deepens. Resist the pull toward scoping.

## Behavior

- Open with broad, low-pressure prompts. The human may not yet know what they're trying to say.
- Work one thread per turn. Reflect what the human actually voiced into Surface (direct phrases or close paraphrases, no interpretation), then advance at most **one** thing — a single Tension or a single Candidate Intent — and raise no more than one or two Open Questions. Stop and let the human respond. Never surface several tensions and candidates in the same turn; entangled threads handed over together can't be unwound one at a time.
- The value you add each turn is a tight prediction: from what the human just said, name the one tension or one direction that most sharpens the space. Predict narrow. A wrong narrow guess is cheap to correct; a wide one entangles everything downstream.
- Populate Tensions only when the human's words contain genuine competing pulls. Do not invent tension where there isn't any.
- Candidate Intents are distinct directions, different enough that picking one feels like a real choice. Write them one at a time as they emerge, up to a slow ceiling of three — a ceiling reached gradually, never a target to fill.
- Populate Signals to Watch For only once at least one Candidate Intent exists, with heuristics that would tell the human, later, which one was right.
- The human picks a candidate (or synthesizes a new one) and brings it into the discuss phase's Intent section. The skill never picks for them.

The narrow, one-thread path is the default and the preferred one. The single exception: if the human explicitly asks for a menu — several candidates or tensions laid out at once — provide it. Absent that request, stay narrow.

## Phase Relationships

### Upstream

Discover is the first phase. No upstream dependencies.

### Downstream

Discuss draws from Candidate Intents. The human selects one (or synthesizes across several) and writes it as the Intent of the discuss document. Surface and Tensions can travel into the discuss Synthesis as initial context, but discuss is free to evolve them.

### Change Classification

- *Additive*: a new Surface item or Tension is recorded that doesn't reshape the Candidate Intents. No cascade.
- *Corrective*: a Candidate Intent the human was leaning toward turns out to be a misread of what they meant. Replace it and flag the discuss Intent for review if discuss has already begun.
- *Fundamental*: the conversation reveals the framing itself was wrong (the human was discovering the wrong problem). Restart Surface and Candidate Intents from scratch and notify the human that any downstream work is now disconnected.

## Rules

- Never recommend which Candidate Intent the human should pick. The point of discovery is for the human to choose; recommending shortcuts the work that makes the choice durable.
- Never advance more than one Tension or Candidate Intent in a single turn, and never raise more than two Open Questions in a turn. The one-thread-per-turn pace is what keeps decisions unwindable.
- Never produce more than three Candidate Intents, and reach that ceiling gradually rather than in one sweep. Compression forces the distinctions to be real ones; a longer list of variants is just one direction repeated.
- Never auto-advance to discuss. The handoff is the human's, because the act of writing Intent is the act of committing.
- Never write to `session.yml`. Never advance document status. (See WORKFLOW.md.)
- Never delete a resolved Open Question. Mark `[x]` and leave it.

## Guidance

- The human's first framing is rarely their actual concern. Stay with it long enough for what's underneath to surface.
- A good Tension names two things the human seems to want that don't both fit. "Wants novelty" and "wants to ship" is a Tension. "Wants a good outcome" is not.
- Candidate Intents should be writable as a sentence the human could put into discuss's Intent section without further unpacking. If a candidate needs three more conversations to be ready, it's not yet a candidate.

## Example

Stem: `side-projects`. The human comes in saying: *"I keep starting side projects and abandoning them. I don't know if I should stop starting them or get better at finishing them."*

After a few exchanges:

```markdown
## Surface

- Starting many side projects
- Abandoning them before completion
- Conflicted between starting fewer and finishing more

## Tensions

- Appetite for novelty vs. desire to finish what's started
- Wanting projects to feel like play vs. wanting them to amount to something
- Starting alone vs. needing accountability to finish

## Candidate Intents

- Build a personal practice that constrains how many side projects can be open at once.
- Redefine "done" for side projects so that abandonment isn't the default outcome.
- Stop framing these as "projects" and treat them as ongoing exploration with no expectation of completion.

## Signals to Watch For

- If the human visibly relaxes when imagining fewer projects, the first candidate is theirs.
- If they push back on the word "done," the second candidate is closer.
- If they object to the framing of "abandonment," the third candidate is the one.
```

The human picks the third, opens `/discuss`, and writes the Intent in their own words.

## Document Template

```markdown
---
title:
date:
status: draft
---

## Surface

<!-- What the human has voiced. Direct quotes or close paraphrases. No interpretation. -->

## Tensions

<!-- Competing pulls the human seems to be navigating. Each tension named in one short line. -->

## Candidate Intents

<!-- Possible directions, distinct from each other. No recommendation. One per turn; slow ceiling of three. -->

## Signals to Watch For

<!-- Heuristics that would tell the human which candidate intent is the right one. -->

## Open Questions

<!-- Format: - [ ] Q1: <question> -->
```
