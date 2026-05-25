# Coach · Build Cheatsheet

This cheatsheet shows you how to build Coach, your AI coach web app, from scratch in about ninety minutes. The wiring is the same for everyone. The prompts you fill in are what make your version different.

You will use fourteen anchor prompts and five personality slots. The anchor prompts are the same for everyone. The personality slots are the choices that make Coach feel like yours.

This is the polished version of the cheatsheet. During the live session, a hook also writes a raw version to `cheatsheet/coach-build-raw.md` as I type. After the session, I hand-edit the raw version into this polished version and send it out.

---

## Pre-flight (do this once)

- [ ] Default model: `anthropic/claude-sonnet-4.6` through the Vercel AI Gateway. You can confirm by running `gateway.getAvailableModels()` if you are not sure which model is current.
- [ ] MCPs installed: `claude-mem`, `context7`, `stitch`, and `shadcn`.
- [ ] Skills installed: the `superpowers` plugin.
- [ ] Your personal CLAUDE.md is at `~/.claude/CLAUDE.md`. You filled it in by customizing `claude-md-kit/CLAUDE.md.template`.
- [ ] You forked the starter repo: `gh repo clone harshitbadiger/coach-template <your-name>-coach`.
- [ ] You linked your Vercel project: run `vercel link` and then `vercel env pull .env.local` inside the cloned folder.

## Personality slots (decide these before you start)

1. **Your coach's name.** Examples are Atlas, Sage, or Daimon. This name appears in headings and on the open-graph image.
2. **Voice adjective.** One word that describes how your coach speaks. Examples are terse, lyrical, blunt, or warm.
3. **Three features.** The defaults are Chat, Roast, and Receipt. You can swap one of them for something else if you want.
4. **Accent color.** Pick one color value, either an OKLCH value or a hex code.
5. **Planted bug topic.** This is the bug you will demonstrate with the /debug command during the build.

---

## Build sequence

### 1. Load context (anchor)

**What you type:**
```
open this project, load any prior session memory
```

**What should happen:** claude-mem reports either the prior context or "no prior" on a fresh clone of the repo.

### 2. Decide what to build (anchor and slot)

**What you type:**
```
Let me think through what this AI coach should be. Three features. Brainstorm with me.
```

**What should happen:** The `superpowers:brainstorming` skill turns on by itself. After three minutes of dialogue, you have three features and the plan to use CLAUDE.md as the system prompt.

**Personality slot:** Your three features. The defaults are Chat, Roast, and Receipt.

**Recovery move:** If Claude proposes more than three features, say "narrow this to three."

### 3. Stress-test the design (anchor)

**What you type:**
```
/grillme on these three features and the plan to use CLAUDE.md as the system prompt.
```

**What should happen:** The /grillme command asks you hard questions about your plan. Get through one full round.

### 4. Lock the plan (anchor)

**What you type:**
```
/plan
```

Then approve the plan when Claude shows it to you.

**What should happen:** The `superpowers:writing-plans` skill produces a structured plan that gets saved to `docs/superpowers/plans/`.

### 5. Send three helpers in parallel (anchor)

**What you type:**
```
Send three subagents in parallel. Each one builds one feature end-to-end, including tests.
```

**What should happen:** The `superpowers:dispatching-parallel-agents` skill turns on. Three subagents work at the same time. Their reports come back together within thirty to sixty seconds.

### 6. Doc lookups during the build (anchor)

**What you type:** Nothing extra. This happens automatically whenever Claude references Next.js, the AI SDK, or any other library.

**What should happen:** The context7 MCP runs in the background and pulls the latest docs into Claude's context.

### 7. Design the brand (anchor and slot)

**What you type:**
```
Use Stitch to make a brand identity for my AI coach. Name the coach <YOUR COACH NAME>. The mood is <YOUR ADJECTIVE>.
```

**What should happen:** Stitch returns a color palette, a set of fonts, and a mood. Apply these tokens to `globals.css`.

**Personality slots:** Your coach's name and your mood adjective.

**Recovery move:** If Stitch returns something generic, say "make it more <a stronger version of your adjective>" and try again.

### 8. Install ready-made components (anchor)

**What you type:**
```
Use shadcn to install the chat components.
```

**What should happen:** shadcn returns the chat column, the message group, and the form input. They land in `components/ui/` with your brand tokens applied.

### 9. Polish the page (anchor)

**What you type:**
```
Apply frontend-design to the chat column. Make it look editorial, not generic.
```

**What should happen:** The frontend-design skill rewrites the chat layout. The page changes from a default look to a designed look.

### 10. Mid-build maintenance (anchor)

**What you type:**
```
/compact
```

Run this whenever the context window starts to feel full.

**What should happen:** The conversation gets summarized while the important state stays in place. Claude's responses speed back up.

### 11. Planted bug and debug (anchor and slot)

**What you type:** Describe the planted bug in your own words.
```
<describe the bug>: <expected behavior> versus <actual behavior>. Find the root cause.
```

**What should happen:** The `superpowers:systematic-debugging` skill and the /debug command trace the bug, find the root cause, and fix it.

**Personality slot:** The topic of your planted bug.

### 12. Write the regression test (anchor)

**What you type:**
```
Write a regression test before applying the fix. Use TDD.
```

**What should happen:** The `superpowers:test-driven-development` skill writes the failing test first. After confirming the test fails, it applies the fix. The test then passes.

### 13. Ship (anchor)

**What you type:**
```
/commit and then git push. Vercel will deploy automatically.
```

**What should happen:** /commit writes a clean commit message. The push goes to GitHub. Vercel sees the push and deploys.

### 14. The Swap (anchor)

**What you type:**
```
Replace src/persona/CLAUDE.md with a very different personality. Then commit and push.
```

**What should happen:** Thirty seconds later, the same URL responds in a different voice. This proves customization is real.

---

## After the session

The Playbook hook has been writing every prompt and every tool event to `cheatsheet/coach-build-raw.md` the whole time. If you want a record of what surprised you, hand-edit that file into your own personal version.

If you copy this cheatsheet and your output looks different from mine, the first place to check is your CLAUDE.md file. The personality you wrote there drives most of what changes between your version and mine.
