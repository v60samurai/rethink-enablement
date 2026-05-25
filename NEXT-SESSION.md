# Where you left off (2026-05-16, after the PRD-IG-Playbook restructure)

Saving state. Everything below is committed. Pick up here.

## Status: ready for dry run

All deliverables for Sunday's session are in place. The two products are **Coach** (Part 1) and **Editor** (Part 2). The deck has been restructured from 32 slides to 21. The build steps are no longer slides — they live in `docs/coach/SESSION_PLAYBOOK.md` and get executed in VS Code with parallel subagent dispatch.

No blockers. Dry run is the next move.

## The new flow in one paragraph

The deck runs slides 1 through 12 in the first 18 minutes of Part 1. At slide 12 ("Switch to VS Code"), you stop clicking the deck and move to VS Code. From there, you follow `docs/coach/SESSION_PLAYBOOK.md` (a 14-prompt linear execution doc) to build Coach with three parallel subagents. When the URL is live and the Studio Swap demo is done, you switch back to the deck for slide 13 (Part 2 intro for Editor).

## First three things to do when you sit back down

1. **Open `teaching-deck/index.html` in a browser** (fullscreen or present mode). Walk through all 21 slides once. Confirm the new language reads right when you say it aloud. The deck is now much shorter; the magic of Part 1 is in the live build that follows slide 12, not in the deck itself.

2. **Read `docs/coach/SESSION_PLAYBOOK.md` end to end.** This is the script you follow during Part 1. The 14 prompts, the parallel subagent dispatch, the planted bug, the Studio Swap. Time yourself reading it once.

3. **Solo dry run.** Create a fresh empty folder at `~/Projects/coach-demo/`. Open VS Code there. Run `vercel link` and `vercel env pull .env.local`. Then follow the Session Playbook end to end. Time yourself. Target: 30 minutes from Phase 1 (load context) through Phase 7 (Studio Swap). Note any prompt that needed a retry or any phase that ran long.

## What to refer to

| Use | File |
|---|---|
| Project on monitor Sunday | `teaching-deck/index.html` (21 slides, plain English) |
| Script for the Part 1 live build | `docs/coach/SESSION_PLAYBOOK.md` (14 prompts in order) |
| Coach product brief | `docs/coach/PRD.md` |
| Coach technical reference | `docs/coach/IMPLEMENTATION_GUIDE.md` |
| Send to attendees three days before | `session-plan/pre-work.pdf` plus the `claude-md-kit/` folder |
| Send to attendees three days before or in-session | `session-plan/editor-brief.md` |
| Auto-captures during the live build | `cheatsheet/coach-build-raw.md` |
| Hand-edit Monday | `cheatsheet/coach-build.md` |
| Read before the dry run | `session-plan/run-of-show.md` |

## Known open items

1. **The Vercel project for Coach is not linked yet.** Need `vercel link` in your dry-run folder before the session. Plus enable AI Gateway in the project's dashboard settings.
2. **The `shadcn` MCP was not detected by the validation script last time we ran it.** Install with `claude mcp add shadcn` if you have not already.
3. **The Editor brief assumes an `editor-tools.ts` pattern with tool use.** You have not built Editor solo yet. The brief is unvalidated. The dry run for Part 1 (Coach) is critical. For Part 2 (Editor), trust the brief.
4. **The Coach docs at `docs/coach/`** are the source of truth for Part 1. If you edit any of them, also update the deck slides 9, 10, or 11 so they stay in sync.

## Recent commits (the PRD-IG-Playbook restructure)

```
The Coach PRD written at docs/coach/PRD.md (216 lines).
The Coach Implementation Guide written at docs/coach/IMPLEMENTATION_GUIDE.md (307 lines).
The Coach Session Playbook written at docs/coach/SESSION_PLAYBOOK.md (268 lines).
The deck restructured: 14 build-step slides replaced with 4 artifact slides.
The deck went from 32 slides to 21 slides.
The run-of-show Phase 2 rewritten to reflect "deck through slide 12, then VS Code".
The cheatsheet README updated to point to the Session Playbook as canonical.
The pre-work Part 1 paragraph updated to mention the PRD-IG-Playbook system.
The pre-work PDF regenerated.
```

## Historical files (do not need to touch)

The original design spec and plan have moved to `archive/superpowers/`. They still use the Atelier name. That is intentional. They are historical records of design decisions as they were made before the PRD-IG-Playbook restructure.

## Templates

My personal PRD and implementation templates live at `templates/`. The Coach docs at `docs/coach/` were derived from these.

## When the session ends Sunday

The Playbook hook will have populated `cheatsheet/coach-build-raw.md` with every prompt typed during the live build. Monday morning, hand-edit it into the polished `cheatsheet/coach-build.md` and mail it to attendees with the recording link.

---

*Saved 2026-05-16, after the PRD-IG-Playbook restructure. Resume any time.*
