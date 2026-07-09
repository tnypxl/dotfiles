---
name: lets
description: |
  - Stage a piece of work through one collaborative harness.
  - Invoked as `/lets {verb} {prompt}` where verb is one of discuss, research, plan, execute.
  - Use whenever the human says "let's discuss/research/plan/execute".
  - Use whenever the human references a stem's notebook.md/research.md/plan.md/execute.md.
  - Use whenever the human wants to think a piece of work through in stages and capture it in durable documents — for code, writing, decisions, research, or personal planning.
---

# /lets

This skill is the dispatcher and the per-verb playbooks. It carries what you need to act. The conceptual contract — the stem, living vs. ledger, cadence, drift, voice — lives in [`./reference/WORKFLOW.md`](./reference/WORKFLOW.md). Read only the section a step below points you to. Do not read the whole file up front — that's the context budget this skill is designed around.

## Quick Reference

| Verb | Artifact | Subagent | Template |
|---|---|---|---|
| discuss | `notebook.md` | — (direct conversation) | `./templates/notebook.md` |
| research | `research.md` | `researcher` | `./templates/research.md` |
| plan | `plan.md` | `planner` | `./templates/plan.md` |
| execute | `execute.md` | `executor` | `./templates/execute.md` |

Setup mode redirects the artifact (not the verb) — see step 5.

## Guardrails

- Never write to an artifact whose frontmatter is `status: locked`. Say so and stop (step 4).
- Never delegate to a subagent without assembling the `<task_contract>` below and handing it over whole.
- Never dump more than one or two threads/questions/tasks into an artifact in a single turn (cadence, `./reference/WORKFLOW.md` § Cadence) — meter it, then hand the turn back.
- Never resolve drift yourself. Surface the suspicion; the human decides whether to run the correction sweep.
- In setup mode, never scrub harness vocabulary (domain, workflow, stem, verb) from the output — that inversion is correct there and only there.

## Dispatch

Input: `{verb} {prompt}`. First token is the verb; remainder is the prompt.

1. **Resolve verb.** Must be one of `discuss`, `research`, `plan`, `execute`. If missing or unrecognized: ask which verb is meant, then stop until answered.
2. **Resolve stem.** Read `session.yml` at the project root for `stem`, `note:`, and `setup:` (optional; `domain` or `workflow`).
   - If `session.yml` is missing: ask the human for a stem name, create `session.yml` with that `stem` and empty `note`, then continue.
   - Find the stem folder beside `session.yml` (`{index}.{stem}`). If absent: allocate the next index (highest existing stem index + 1, else 1) and create the folder.
3. **Resolve artifact.** Map verb → file per the Quick reference table. If the file doesn't exist, scaffold it from the matching template with `status: active`.
4. **Lock guard.** If the target artifact's frontmatter is `status: locked`: state that it's read-only and stop — do not proceed to the playbook. (Exception: during an execute-driven correction sweep, if the sweep reaches a locked upstream artifact, surface the contradiction and ask to unlock before changing anything.)
5. **Setup mode check.** If `setup:` is set in `session.yml`, it overrides the artifact target and all `domain:`/`workflow:` selectors:
   - `setup: domain` → target becomes `.agents/domains/{stem}.md`
   - `setup: workflow` → target becomes `.agents/workflows/{stem}.md`
   - Skip step 6. Go to step 7.
6. **Resolve context (non-setup only).** Run `./scripts/resolve-context.sh` from the skill's base directory, with the project root as the working directory (it walks upward to find `session.yml`).
   - Nonzero exit: it has already printed a resolution or coupling error to stderr. Surface that message verbatim and stop — do not proceed to the playbook.
   - Zero exit: it emits `DOMAIN_NAME` / `DOMAIN_FILE` / `WORKFLOW_NAME` / `WORKFLOW_FILE`. Read any non-empty `DOMAIN_FILE` as standards the deliverable must follow; read any non-empty `WORKFLOW_FILE` for per-verb tuning. Empty is valid — it means no selector, nothing to read. (Precedence and coupling: `./reference/WORKFLOW.md` § Selectors.)
7. **Load the voice.** Read `./reference/VOICE.md`. It governs everything produced this turn — conversation and artifact alike.
8. **Run the verb's playbook** (below), advancing one or two threads at a time (`./reference/WORKFLOW.md` § Cadence), then hand the next move back to the human.

## Task Contract

Every subagent hand-off (`researcher`, `planner`, `executor`) is a single assembled payload, not a paragraph of instructions restated ad hoc. Build it from this template each time, filling only the fields that verb specifies:

```xml
<task_contract>
  {verb}research | plan | execute{/verb}
  {stem}{stem name}{/stem}
  {scope}
    {bounded description of what this subagent is being asked to do —
     never hand a subagent the full notebook/research/plan; hand it
     the slice relevant to this call}
  {/scope}
  {upstream}
    <!-- omit any that don't exist yet -->
    <approach_ref>{path to notebook.md, Approach section only}</approach_ref>
    <research_ref>{path to research.md}</research_ref>
    <plan_ref>{path to plan.md, this task only}</plan_ref>
  {/upstream}
  {standards}
    <!-- from dispatch step 6; omit if empty -->
    <domain_ref>{DOMAIN_FILE, if non-empty}</domain_ref>
    <workflow_ref>{WORKFLOW_FILE, if non-empty}</workflow_ref>
  {/standards}
  <governing_refs>
    {workflow}./reference/WORKFLOW.md{/workflow}
    {voice}./reference/VOICE.md{/voice}
  </governing_refs>
</task_contract>
```
