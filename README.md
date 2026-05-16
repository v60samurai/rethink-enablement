# Rethink Enablement

<!-- TODO HARSHIT: Replace this block with two or three sentences of your lede.
     Tone match for pre-work.html — reflective prose, no fragments, no em dashes,
     no product names. Something that explains in your own voice what this repo
     is and why someone would clone it before Sunday. Delete this comment block
     once you have written the opening. -->

This repository is the pre-work kit for the Sunday session. If you have received the pre-work document, the kit referenced inside it lives here.

## What is in this repo

| Folder | What lives here |
|---|---|
| `session-plan/` | The pre-work document itself (`pre-work.html` and `building-pre-work-rethink-systems.pdf`) and the validation script (`validate-prework.sh`) that confirms your machine is ready. |
| `claude-md-kit/` | Everything you need to write your personal `~/.claude/CLAUDE.md` file. `INTERVIEW.md` is the interview prompt you paste into Claude Code, `CLAUDE.md.template` is the spine for the manual path, `CUSTOMIZATION.md` is the walkthrough for what each section is asking for, and `CLAUDE.md.example` is a filled-in reference so you can see the shape of a finished file. |

## What to do

1. Clone this repository so you have the kit on disk.

   ```bash
   git clone https://github.com/v60samurai/rethink-enablement
   ```

2. Open `session-plan/building-pre-work-rethink-systems.pdf` and follow it from the top. Every step you need is in that document, including the order in which to install tools, the MCPs to register, and the two paths for writing your `CLAUDE.md` file.

3. When you reach the validation step, run the script from the directory just above the clone, so the path matches what the pre-work document expects:

   ```bash
   bash rethink-enablement/session-plan/validate-prework.sh
   ```

   A row of green check marks means you are ready for Sunday. Any red cross means something is missing, and the line above will tell you what to install or which command to run.

---

*Owned by Harshit Badiger.*
