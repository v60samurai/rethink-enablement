# CLAUDE.md Kit

Four files. Ten to fifteen minutes during pre-work.

| File | What it is |
|---|---|
| `CLAUDE.md.template` | The **spine**. A structural skeleton with questions per section. Not a copy of anyone else's CLAUDE.md. You fill each section in your own words. |
| `INTERVIEW.md` | A **Claude prompt** you can paste into a fresh Claude Code session. Claude reads the spine, asks you questions section by section, and generates your CLAUDE.md from your answers. **Recommended path.** |
| `CUSTOMIZATION.md` | The walkthrough. Explains why each section matters, with example answers from different kinds of builders. |
| `CLAUDE.md.example` | One specific person's fully filled file (Harshit's). For reference only. Do not copy it. |

## The two paths

**Path A: Interview (recommended).** Open Claude Code in a fresh session. Paste the prompt from `INTERVIEW.md`. Claude asks you the questions. You answer in plain English. Claude generates the file and saves it to `~/.claude/CLAUDE.md`. Takes ten to fifteen minutes.

**Path B: Manual.** Copy `CLAUDE.md.template` to `~/.claude/CLAUDE.md`. Open it in your editor. Fill in each section in your own words. Use `CUSTOMIZATION.md` for guidance. Takes fifteen to thirty minutes.

Both paths produce the same kind of file. Pick whichever feels more natural.

## Verify

After either path, open Claude Code and type:

```
summarize my CLAUDE.md
```

The summary should mirror what you wrote. If it does not, your file is not loading at the expected path. Check that the file exists at exactly `~/.claude/CLAUDE.md`.
