# Templates

My personal templates for building products solo with Claude Code. Three folders, three jobs.

| Folder | What it is | Used by |
|---|---|---|
| `prd/` | Two PRD templates plus example PRDs from past projects. | The Product step of the Build Order. |
| `brand/` | Brand guide template (`template.md`). Single source of truth for branding, UI, UX. | The Branding step, between PRD and code. |
| `shipwright/` | Shipwright is my published skill on GitHub. It turns a PRD into three executable documents: an Implementation Guide, a Session Playbook, and a Final Push checklist. The folder here holds the templates that ship with the skill. | The Implementation step. Generates the IG and Playbook used by the build agents. |

## Shipwright

The skill lives at <https://github.com/v60samurai/shipwright>. Fork it, star it, run it on your own PRDs.

The folder structure here mirrors what Shipwright produces:

| File | What it is |
|---|---|
| `IMPLEMENTATION_GUIDE.md` | Technical reference template. Stack patterns, schema scaffolds, analytics taxonomy, security checklist, performance targets, launch checklist. |
| `SESSION_PLAYBOOK.md` | Linear execution template. Session-by-session order with exact Claude Code prompts. |
| `FINAL_PUSH.md` | Polish-layer template. Demo prep, UI micro-details, milestone moments. |

## The three-document workflow

1. Write the PRD using `prd/template-lean-submission.md` or `prd/template-full-depth.md`.
2. Fill in the brand guide using `brand/template.md`. This is a separate session in the workshop; I touch on the philosophy in Part 1 but the deep dive is its own session.
3. Run Shipwright on the PRD to produce the Implementation Guide, Session Playbook, and Final Push.
4. Hand those documents to Claude Code with parallel subagents and ship.

## Worked example

`docs/coach/` in this repo is a complete worked example of the three-document workflow applied to Coach (the Part 1 product). The PRD is in `docs/coach/PRD.md`. The Implementation Guide is in `docs/coach/IMPLEMENTATION_GUIDE.md`. The Session Playbook is in `docs/coach/SESSION_PLAYBOOK.md`. All three were derived from these templates.

## How to use it on your own product

1. Copy the relevant PRD template into your project's `docs/` folder.
2. Fill it in. The Decision Rationale rule applies: every non-obvious choice needs a one-line defense.
3. Run Shipwright on the PRD to generate your Implementation Guide and Session Playbook.
4. Hand them to Claude Code. Build.
