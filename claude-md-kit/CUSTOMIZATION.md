# Filling in the CLAUDE.md Spine

The template at `CLAUDE.md.template` is a **spine**. It is a structural skeleton with questions, not a pre-filled file with someone else's answers. You fill each section in your own words. The result is a CLAUDE.md that sounds like you.

This guide is the walkthrough. It explains why each section matters and shows you the range of good answers across different kinds of builders.

## Why this matters

The CLAUDE.md sits at `~/.claude/CLAUDE.md`. Every Claude Code session in every project reads it. It is the single largest lever you have over how Claude behaves with you.

A generic CLAUDE.md (or no CLAUDE.md) gives you a generic assistant. A specific one gives you a collaborator who pushes back when you cut corners, formats answers the way you read best, knows your stack, and refuses the patterns you hate.

The example file at `CLAUDE.md.example` is one person's fully filled version. Read it once to see what a complete file looks like. Do not copy it. Your CLAUDE.md should sound like you, not like the example.

## The nine sections of the spine

### Section 1: Identity

Who you are, where you build, your public handle.

The point: when Claude reads "Daisy Chen, senior PM, NYC" it answers differently than when it has no context. Specific identity unlocks specific responses.

### Section 2: How you want Claude to relate to you

CTO. Pair programmer. Junior dev you direct. Senior engineer you direct. This single choice changes the tone of every Claude response in every session.

### Section 3: Your build approach

The order you follow when you build something. Some people go PRD first. Some people spike first. Some people draw on paper. There is no right answer. Tell Claude yours.

### Section 4: Stack defaults

What technologies you reach for first. Be specific. "React" is less useful than "React 19 with Next.js 16 App Router and Tailwind 4." The more specific, the less Claude has to guess.

If you do not have a stack yet, write what you are learning. Update it as you learn.

### Section 5: Behavioral rules

The non-negotiable rules. The template ships with six universal rules that apply to almost everyone. Add three to five of your own.

The rules should be things you have learned the hard way. Generic best practices are everywhere. Your rules are what makes your CLAUDE.md yours.

### Section 6: Forbidden patterns

Libraries you have tried and rejected. Syntax you hate. Idioms you avoid. Be specific.

This is the most underrated section. Saying "no moment.js, no date-fns, dayjs only" prevents Claude from making the same wrong choice you made years ago.

### Section 7: Response style

How Claude talks to you. Terse or explanatory. Bullets or paragraphs. Lead with the answer or build to it. One paragraph is enough.

This is the rule that affects the most messages, so it is worth iterating on. Update it when you find yourself editing the same kind of Claude response twice.

### Section 8: Quality bar

What "good" means for you. What do you check before you call something done? The template has universal defaults. Add your own.

### Section 9: Knowledge System (optional)

Some builders persist learning across sessions in journals, past-mistakes files, and decision records. If you want this, describe how. If you do not, delete the section.

## How to install

```bash
cp claude-md-kit/CLAUDE.md.template ~/.claude/CLAUDE.md
```

Then open `~/.claude/CLAUDE.md` in your editor and fill each section in your own words. Delete the questions and example boxes when you are done. Aim for between 60 and 200 lines total.

## How to verify it works

Open Claude Code. Type:

```
summarize my CLAUDE.md
```

Claude should return a summary that matches what you wrote. If Claude returns a generic answer like "you are a developer" when you wrote "you are a senior PM at a startup," the file is not loading. Check that the path is exactly `~/.claude/CLAUDE.md`.

## When to update it

- After any correction Claude needed twice. The rule should have caught it the first time.
- After any preference you stated twice in a session.
- After any Claude response that surprised you (good or bad).
- Read the whole file once a month and prune what no longer fits.

## On length

A good first CLAUDE.md is 60 to 200 lines. The complete spine, fully filled, is around 150 lines. If you find yourself adding rules every week, you are using it right. If the file passes 400 lines, split off project-specific rules into project-level `CLAUDE.md` files and keep `~/.claude/CLAUDE.md` global.

## Reference

`CLAUDE.md.example` is one specific person's fully filled file (Harshit's). Read it once to see what "done" looks like. Then write your own from the spine. Your version should not look like the example.
