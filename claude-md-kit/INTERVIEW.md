# The CLAUDE.md Interview

This file is a **prompt**. Copy the section below the line into a fresh Claude Code session and send it. Claude will read the spine template, walk you through each section by asking you short questions, then generate a personalized `CLAUDE.md` based on your answers.

This is the **recommended way** to create your global CLAUDE.md. It is faster than filling the template by hand. The output sounds like you because Claude builds the file from your answers, not from a copy of someone else's file.

The interview takes about ten to fifteen minutes. At the end, Claude shows you the final file and saves it to `~/.claude/CLAUDE.md` after you approve.

---

You are helping me create my personal CLAUDE.md file. The file goes at `~/.claude/CLAUDE.md` and Claude Code reads it on every session.

**Your task**

1. Read the spine at `claude-md-kit/CLAUDE.md.template`. That spine has nine sections. It contains questions, not answers.
2. For each section, ask me two to four short questions. Wait for my answers before moving to the next section.
3. After all sections are answered, write a complete CLAUDE.md file in my voice using my answers.
4. Show me the draft file. Do not save it yet.
5. Ask if anything needs to change. Iterate if needed.
6. Once I approve, save the file to `~/.claude/CLAUDE.md` (create the directory if it does not exist).
7. Verify it saved by reading it back and showing me the first ten lines.

**Principles to follow** (from Boris Cherny, the creator of Claude Code, and other senior Claude Code users)

- Claude Code is an agent with hands, not a chatbot. The CLAUDE.md you build should treat Claude as a coworker the user delegates tasks to, not a chatbot they ask questions of.
- A good CLAUDE.md is short and specific. Target between sixty and two hundred lines. Specific rules beat generic best practices. "Use TypeScript strict mode" beats "follow best practices."
- The CLAUDE.md should be opinionated. Vague preferences produce vague responses. If the user says "be helpful," push back and ask them what helpful means to them.
- Forbid patterns the user has tried and rejected. This is the most underrated section. It prevents Claude from regenerating the user's past mistakes.
- The response style rule has the highest leverage because it affects every single response. Spend extra time on it. If the user gives a vague answer, ask a follow-up.
- The behavioral rules should be things the user learned the hard way, not generic best practices everyone knows.
- The build approach section should describe the user's actual order of operations, not an abstract methodology.
- If the user does not know an answer to a question, give them three example answers from different kinds of builders and let them pick or adapt.

**Rules for the interview**

- Ask one section at a time. Do not show the user the whole questionnaire upfront.
- Per section, ask two to four questions. Resist the urge to ask more.
- If an answer is vague, ask one follow-up. If still vague, offer three example answers.
- Keep the final file under two hundred lines.
- Delete all template scaffolding (the questions, the example boxes, the preamble) before saving.
- The final file should use the user's own words, not the template's example phrasings.
- Use plain English. No em-dashes. Full sentences not fragments.

**Start now** by reading `claude-md-kit/CLAUDE.md.template` so you understand the nine sections. Then ask me the first question for Section 1 (Identity).
