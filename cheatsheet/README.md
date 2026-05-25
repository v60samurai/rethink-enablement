# Cheatsheet

Two files live here.

| File | What it is |
|---|---|
| `coach-build.md` | The polished cheatsheet. Anchor prompts plus personality slots. Anyone can read it and rebuild Coach from scratch. |
| `coach-build-raw.md` | The raw version that gets written during the live session by `.claude/hooks/playbook.sh`. After the session, Harshit hand-edits it into `coach-build.md`. |

## How this relates to the Coach docs

The canonical build doc is `docs/coach/SESSION_PLAYBOOK.md`. That is the linear execution sequence Harshit follows during the live session.

This cheatsheet folder is the attendee-facing version. After the session, attendees who want to rebuild Coach on their own can read `coach-build.md`. About seventy percent of the prompts are anchor prompts (they stay the same for everyone). The other thirty percent are personality slots (your coach's name, voice, color, three features, and planted bug).

For Part 2 (Editor) attendees, the relevant document is `session-plan/editor-brief.md`. That brief is both the PRD and the implementation guide for Editor in one document, scoped to the forty-five-minute build window.
