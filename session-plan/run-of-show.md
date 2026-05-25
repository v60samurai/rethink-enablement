# Run of Show: 120-Minute Rethink Enablement

One call, two parts. The audience is mixed and includes absolute beginners. Everyone arrives with Claude Code installed and signed into a paid Pro or Max subscription, per the pre-work doc.

## Why 120 minutes

Ninety minutes was the sweet spot when the brief was "ship a tiny prototype." The brief is now "real MVP" with Next.js, a backend route, and a Vercel deploy from GitHub. Ninety minutes is not enough for absolute beginners to absorb Tier 0 and Tier 1 and also ship that MVP. Sixty minutes would be a lecture. One hundred and twenty minutes gives Part 1 the breathing room to teach the build loop properly. Then Part 2 has time to actually ship.

Going past 120 minutes risks fatigue, especially for non-coders. The line is here.

## Pre-work (sent three days before the session)

The pre-work doc is its own deliverable. The session assumes the following are true for every attendee:

- Claude Code is installed and the attendee is logged into a paid Pro or Max subscription.
- The `claude` command runs successfully. The pre-work checklist confirms this with a screenshot.
- A GitHub account exists. The `gh` CLI is installed and authenticated.
- A Vercel account exists. The `vercel` CLI is installed and authenticated.
- Node 20 or higher is installed. pnpm is installed.
- The attendee has forked the starter template (link provided in pre-work) into their own GitHub account.

Anyone who arrives without pre-work done is paired with a buddy who has done it. The unpaired attendee watches Part 1 and catches up on install during the break. They will not ship in Part 2, but they leave with the loop in their head and a setup that works tomorrow.

## Success definition

This session worked if all four of these are true:

- Everyone has Tier 1 installed and a customized global CLAUDE.md by minute 55.
- At least seventy percent of attendees have a deployed Vercel URL with their MVP by minute 115.
- Every shipped URL works on the first click.
- Attendees can describe the Build Order in their own words: load context, brainstorm, plan, build, debug, ship.

The seventy-percent target is realistic given the mixed audience. The buddy system carries the rest. The ones who do not ship will leave with a working setup and the loop in their heads. They will ship next week.

## Part 1: Style walkthrough (0:00 to 0:55)

### Phase 1: Welcome, Tier 0 verification, customize CLAUDE.md (0:00 to 0:15)

**0:00 to 0:03.** Welcome. Frame the deal: in two hours, every one of you ships a real MVP at your own Vercel URL.

**0:03 to 0:08.** Tier 0 verification. Everyone opens a terminal and types `claude`. Anyone whose Claude is not running gets immediate triage. The pre-work should have caught this. This is the failsafe.

**0:08 to 0:15.** Customize the global CLAUDE.md. Walk through my own CLAUDE.md aloud. Identity, Build Order, stack defaults, rules. Everyone forks the `CLAUDE.md.template` and fills in their version live during the call. This is the most important Tier 0 step. The CLAUDE.md is the soul of how Claude works for each person.

### Phase 2: Coach, the live build (0:15 to 0:50)

The deck runs from slide 9 to slide 12 in the first three minutes. Then I switch to VS Code and stay there until the URL is live and the Studio Swap demo is done. The deck does not narrate the build step by step. The Session Playbook does.

**0:15 to 0:16. Slide 9: What we are building.** Show the Coach problem statement on the deck. One minute. Frame: builders make many decisions a day, generic AI does not know their style, Coach is the answer.

**0:16 to 0:17. Slide 10: The PRD.** Show that `docs/coach/PRD.md` exists and was written before the session. Walk through the five key sections (problem, target user, solution, scope, success) in thirty seconds. Frame: "We do not make products up live. PRD first."

**0:17 to 0:18. Slide 11: The Mini Brand.** Show that `docs/coach/BRAND.md` exists. Five sections from the full eighteen-section template. Frame: "Branding deserves its own session. Today we do the mini version: visual idea, type, color, microcopy, what this is not. Five decisions in three minutes from the PRD."

**0:18 to 0:19. Slide 12: From PRD to executable plan.** Show that Shipwright generated two more documents (the Implementation Guide and the Session Playbook) from the PRD. Frame: "Three documents. One skill. The agents will follow the Playbook."

**0:19 to 0:20. Slide 13: Switch to VS Code.** Big simple slide. One sentence: "Now we switch to VS Code." I switch the screen share to the VS Code window.

**0:20 to 0:48. The build in VS Code.** I follow `docs/coach/SESSION_PLAYBOOK.md` step by step. The audience watches the agents work. I narrate what is happening, not what to type. The Playbook has a Budget Summary at the top showing target times and fallback cuts; consult it during the build if behind.

- **0:20 to 0:22.** Phase 1: load context with `claude-mem`, hand Claude the PRD, BRAND, and Implementation Guide.
- **0:22 to 0:25.** Phase 2: `/grillme` and `/plan`. Stress-test and lock the build plan.
- **0:25 to 0:33.** Phase 3: dispatch three subagents in parallel, one per feature. Scope is scaffolded routes only (tests come in Phase 5 if time). This is the central agentic moment. I narrate the concurrency while the three agents work.
- **0:33 to 0:38.** Phase 4: build the UI with Stitch, shadcn, and the frontend-design skill. If a step is slow, simplify to Stitch tokens only and ship.
- **0:38 to 0:41.** Phase 5: plant the bug, /debug traces it, TDD the regression test. **First to cut if behind.** Run `pnpm test` here if Phase 3 skipped it.
- **0:41 to 0:43.** Phase 6: /commit, push, Vercel deploys. URL goes live. I stop talking for sixty seconds.
- **0:43 to 0:45.** Phase 7: The Studio Swap. Replace `src/persona/CLAUDE.md` with a different personality. Push. Same URL, different voice. **Second to cut if behind**; describe verbally if skipped.
- **0:45 to 0:48.** Buffer absorbed slowdowns during the build.

**0:48 to 0:50. The Playbook artifact.** Open `cheatsheet/coach-build-raw.md`. The auto-capture hook has been writing every prompt and every tool event throughout the build. Frame: "every prompt you saw is captured. Tomorrow morning the polished cheatsheet ships to everyone in this room."

I switch back to the deck for slide 13 (Part 2 intro).

### Phase 3: Tier 2 tour and the soft mention (0:50 to 0:55)

**0:50 to 0:53.** A quick Tier 2 tour. One sentence each. When your first failed Vercel deploy email shows up, install `/ship`. When you ship something with auth and want a second opinion, install `/review`. When a fixed bug returns, install `/test`. When your build has two independent tasks, install `dispatching-parallel-agents`. When you join someone else's codebase, install `/explore`. No demos. Just names and the moment to reach for each one.

**0:53 to 0:55.** Soft mention zero-to-ship. One line: "When you start hitting concepts the AI keeps glossing over, like OAuth or SQL joins or Docker, I am building a project called zero-to-ship. Bookmark it. Come back when you hit that wall." Move on. No pitch. Do not link to a specific guide. The guides do not exist yet.

## Break (0:55 to 1:00)

Five minutes. Stretch. Refill water. Buddies sync up.

## Part 2: Editor, your personal writing studio (1:00 to 1:55)

Coach was the warmup. Part 2 steps up. The wiring is the same as Coach plus five new agentic concepts: tool use, multi-step agent loops, voice corpus or few-shot grounding, streaming structured output, and persistence as a stretch goal. Every attendee builds their own version of Editor at `your-name-editor.vercel.app`. The wiring is the same for everyone. Six personalization slots make it theirs.

The brief lives at `session-plan/editor-brief.md` and was shared with the pre-work package. Attendees should have read it before the session.

### Phase 1: Slots and brainstorm (1:00 to 1:10)

**1:00 to 1:03.** Show the Editor spine and the six slots on the deck (slides 25 and 26). Each attendee fills the slots in their head before they write any code: editor persona, voice corpus, three Voice Match registers, domain focus, tool selection, and studio name plus mood.

**1:03 to 1:10.** Run the brainstorming skill. Five minutes of dialogue: "I'm building Editor. Here are my slot values: [persona], [corpus paragraphs], [registers]. What am I missing?" The output is a personal blueprint per attendee.

### Phase 2: Plan, build, ship (1:10 to 1:50)

This is the Coach loop, repeated at Editor's higher complexity.

**1:10 to 1:14.** Run /plan. The writing-plans skill produces the build sequence. Approve it.

**1:14 to 1:22.** Send three subagents in parallel, one per feature (Roast, Tighten, and Match). The same pattern as Coach. Each agent builds its route end-to-end.

**1:22 to 1:30.** Wire the new concepts. Tool use in Roast (four tools in `lib/editor-tools.ts`). Multi-step agent loop in Tighten (Plan, Execute, Validate). Voice corpus and parallel few-shot in Match (`corpus/voice-samples.md` with register tags).

**1:30 to 1:35.** Stitch, shadcn, and frontend-design pass. Brand the studio. Editorial polish. The context7 MCP runs throughout.

**1:35 to 1:38.** /debug + TDD on a planted bug, **only if time permits.** Cut first if behind.

**1:38 to 1:40.** Studio Swap as a query param (`?studio=strunk`). No dropdown UI today. The dropdown is next-week homework.

**1:40 to 1:45.** Run /commit and push. Vercel auto-deploys. The URL goes live. The remaining minutes are buffer for anyone whose deploy fails. Persistence via Vercel KV is **out of scope** for the session.

### Phase 3: Show and ship moment (1:50 to 1:55)

**1:50 to 1:55.** Each attendee drops their Editor URL in chat. We pick three or four and test them against the same draft. A volunteer pastes their last Slack message. The same input goes into three studios and gets three completely different roasts. The Studio Swap moment lands publicly. The best roast wins a coffee.

## Closeout (1:55 to 2:00)

**1:55 to 1:58.** Where from here. Pods kickoff is the natural next step. Their setup is now ready for pods. The Tier 2 list is for self-install at their own pace, triggered by specific moments. Link to baazigar-claude-code-setup.

**1:58 to 2:00.** Q and A buffer. Hard stop at 2:00.

## Risks and mitigations

### Pre-work failed for one or more attendees
**Risk:** Claude is not running on their machine, or they do not have a Vercel or GitHub account.  
**Likelihood:** medium. Some always slip through.  
**Mitigation:** pair them with someone whose setup works. They watch Part 1 and catch up during the break. They will not ship in Part 2 but they leave with the loop.

### Claude rate limits during Part 2
**Risk:** many parallel users hit a shared limit.  
**Likelihood:** low with Pro and Max subscriptions, which are per-attendee and not shared.  
**Mitigation:** verify in the pre-work that subscriptions are paid plans, not free trials.

### Vercel deploy fails for an attendee
**Risk:** environment variables are wrong, or a build error from broken TypeScript.  
**Likelihood:** medium.  
**Mitigation:** the starter template ships with sensible defaults. Vercel's build email surfaces errors clearly. Worst case, they share their screen and I or a buddy takes over for the deploy step. This is the moment where /ship would help. Tier 2 reasoning lands here in retrospect.

### Tool-use loop never invokes any tools
**Risk:** the Roast feature's agent never calls any tools. The tool descriptions are too vague.  
**Likelihood:** medium for first-timers.  
**Mitigation:** each tool description must start with "Use when you suspect..." The brief at `editor-brief.md` section 8 has the fix. Buddies surface this fast.

### Time crunch in Part 2 build
**Risk:** the build phase eats more than 25 minutes.  
**Likelihood:** medium.  
**Mitigation:** the "ship even if incomplete" instruction kicks in at 1:40. The bare minimum is one working route, one page, and one deploy. A URL with placeholder content beats no URL.

### Energy crash past 90 minutes
**Risk:** fatigue, especially for non-coders.  
**Likelihood:** medium.  
**Mitigation:** the break at 0:55 helps. The shipping energy in Phase 2 carries past it. The closeout is short on purpose.

### Audio or video issues mid-session
**Risk:** the usual technical problems.  
**Likelihood:** low to medium.  
**Mitigation:** record the session. The pre-work doc and the template are public. If the call dies, attendees can finish on their own with the deck and the brief.

### Devs get bored during Tier 0
**Risk:** the mixed audience includes some tech-comfortable builders.  
**Likelihood:** high.  
**Mitigation:** ask devs to act as buddies during Phase 1. Give them a side track during Phase 2: implement the Vercel KV persistence stretch goal, or build a fourth Studio preset, or add a fourth Voice Match register.

### Context window fills in someone's Part 2 session
**Risk:** an absolute beginner does not know about /compact, hits the wall, and panics.  
**Likelihood:** medium.  
**Mitigation:** /compact is taught explicitly at 0:40 to 0:43. The Part 2 phase 2 description mentions it as a tool to use when needed. If someone hits this and forgets, a buddy reminds them.

## Zero-to-ship placement

One sentence. One time. Said at 0:53 to 0:55 during the Tier 2 tour. Frame it as future direction, not a thing to look at today. The guides do not exist yet. Do not link to a specific guide. Do not return to it later.

## Dependencies on other deliverables

This run-of-show assumes:

- The three Coach docs at `docs/coach/PRD.md`, `docs/coach/IMPLEMENTATION_GUIDE.md`, and `docs/coach/SESSION_PLAYBOOK.md` exist. These are the source of truth for the live build.
- `claude-md-kit/` exists. The pre-work uses it.
- `cheatsheet/coach-build.md` (skeleton) and `.claude/hooks/playbook.sh` (the auto-capture hook, wired in `.claude/settings.json`) exist.
- The deck at `teaching-deck/index.html` works. It has 21 slides. Part 1 ends at slide 12 ("Switch to VS Code"). Part 2 is slides 13 through 16.
- A clean working folder (for example `~/Projects/coach-demo/`) exists with VS Code open and Claude Code active.
- A Vercel project named `harshit-coach` is linked to the working folder, with a fresh `VERCEL_OIDC_TOKEN` in `.env.local`.
- `session-plan/pre-work.html` and `session-plan/pre-work.pdf` were sent three days out and acknowledged.
- `session-plan/editor-brief.md` was shared with the pre-work package.

If any of these is missing on session day, this plan does not run as written.
