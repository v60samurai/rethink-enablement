# Editor · Part 2 Build Brief

This brief is the combined Implementation Guide and Session Playbook for Editor. The PRD lives at `docs/editor/PRD.md`. The mini brand sheet lives at `docs/editor/BRAND.md`. Read the PRD first to know what you are building. Then read the BRAND to know how it should look. Then use this brief as the build sequence.

The wiring is the same as everyone else's. Six personalization slots make it yours. You will go from an empty folder to a live URL in forty-five minutes.

**Pre-requisite:** You have completed Coach in Part 1. You now have a working Next.js 16 app, the AI SDK v6, and the Vercel AI Gateway set up. You also have a customized `~/.claude/CLAUDE.md` file. Editor reuses every pattern from Coach and adds five new concepts on top.

---

## 1. The real problem we are solving

You write about ten things every week. PRDs. Slack messages. Post drafts. Decision documents. Emails. Pitch decks. Tweets.

For every one of these, you wish you had a brutal editor who:

- Knows your voice and does not rewrite you into someone else.
- Tells you what is vague before someone else does in a review meeting.
- Tightens your writing without hollowing out the point.
- Takes five seconds, not five days.

That tool does not exist. ChatGPT gives generic feedback. Real editors are expensive and slow. Hemingway and Grammarly catch surface flaws but never the buried lede.

Editor is that tool. It lives at a URL you bookmark. It opens fast. It speaks in your voice. You use it three times a day forever.

---

## 2. The common spine (locked for everyone)

Every Editor shipped on Sunday has the same wiring.

**Stack**

- Next.js 16 App Router, TypeScript strict mode, and Tailwind CSS 4.
- AI SDK v6, the plain `ai` package only. Model strings auto-route through the Vercel AI Gateway.
- OIDC auth via `vercel link` and `vercel env pull`. No provider API keys.

**Three API routes**

| Route | Method | Pattern |
|---|---|---|
| `/api/roast` | `POST` | Tool-use agent loop |
| `/api/tighten` | `POST` | Multi-step agent chain (three sequential turns) |
| `/api/match` | `POST` | Parallel few-shot agents (three rewrites concurrent) |

**File system layout**

```
src/
  persona/CLAUDE.md           # your editor's voice (you can reuse Part 1's file as a starter)
  corpus/voice-samples.md     # three to five paragraphs of your best writing (the new file)
  lib/
    editor-tools.ts           # tool definitions used by Roast
    corpus-loader.ts          # reads the corpus and filters by register
    persona-loader.ts         # the same pattern from Coach
  app/
    page.tsx                  # the three-feature UI
    api/roast/route.ts
    api/tighten/route.ts
    api/match/route.ts
```

**The Studio Swap**

A studio is a pair of files: a persona file and a corpus file. The product ships with three pre-built studios. When you swap a studio, both files get replaced. Vercel deploys the new version in about thirty seconds. The same URL then responds with a completely different editor's voice.

---

## 3. The six variant slots (what you fill in)

| Slot | What you fill in | Examples |
|---|---|---|
| 1. Editor persona | The contents of `src/persona/CLAUDE.md` | A strict Strunk-style editor, a kind mentor, a Pitchfork-style critic, or a silent-but-deadly designer |
| 2. Voice corpus | Three to five paragraphs of your best writing in `corpus/voice-samples.md` | Your published essays, your strongest internal memos, your sharpest tweets |
| 3. Three Voice Match registers | Strings in `src/config/registers.ts` | terse, lyrical, formal, spicy, soft, or contrarian |
| 4. Domain focus | Mentioned in your CLAUDE.md. Biases the tool selection. | PM, engineer, designer, marketer, sales, or academic |
| 5. Tool selection | Which three out of eight tools you enable in `editor-tools.ts` | Weak verbs, passive voice, jargon, readability, voice fingerprint, hedging, buried lede, or cliche check |
| 6. Studio name and visual mood | Name in `page.tsx`, theme tokens in `globals.css` via Stitch | "The Workshop" with editorial-warm, "Roast Lab" with neon-brutalist, or "Studio Pause" with quiet-agency |

Fill in these slots before you start the build. They drive every prompt you type.

---

## 4. The three features in detail

### Feature 1: Roast (uses tool use)

**The new skill you learn:** Tool use, also called function calling. The AI calls back into your own code while it is thinking about a response. This is a different mental model from Coach's single-shot prompts.

**Architecture**

```
client : POST /api/roast { text }
              :
  generateText({
    model: 'anthropic/claude-sonnet-4.6',
    system: <persona plus corpus context>,
    prompt: <the text to roast>,
    tools: {
      find_weak_verbs:     { description, inputSchema, execute(text) },
      measure_readability: { description, inputSchema, execute(text) },
      check_jargon:        { description, inputSchema, execute(text, domain) },
      score_voice_match:   { description, inputSchema, execute(text, corpus) },
    },
    stopWhen: stepCountIs(8),
  })
              :
  The agent decides which tools to call. It receives the results.
  Then it writes the critique using the persona plus corpus context.
              :
  The response streams back: each tool result lands as a card, then the
  synthesis paragraph types out.
```

**Seed build prompt:**

```
Build the Roast feature. POST /api/roast accepts { text: string }.
Use generateText with tools (this is the AI SDK v6 pattern). The four
tools live in src/lib/editor-tools.ts. Each tool returns deterministic
results (no LLM inside the tools). The agent loop decides which tools
to call, receives the results, and writes a critique using the persona
plus corpus context. Stream the response. Return both the tool-call
trace and the final text.
```

**Verify points:**

- The network tab on /api/roast shows multiple `tool_call` and `tool_result` events.
- The tools return correct deterministic outputs for known inputs (you will write four unit tests in `lib/editor-tools.test.ts`).
- The synthesis paragraph references the tool findings, not generic critique.
- If you remove a tool, the agent loop still works with the remaining tools.

**Why this matters:**

Without tool use, Roast becomes "ask the LLM what it thinks of this text." The output is generic. The audience cannot tell it from ChatGPT. The "tool use" concept stays abstract instead of becoming muscle memory.

---

### Feature 2: Tighten (uses a multi-step agent loop)

**The new skill you learn:** Sequential agent chains. This feature runs three LLM calls in a row. Each call uses the previous call's output. This is the foundation of every real agent product.

**Architecture**

```
client : POST /api/tighten { text }
              :
  Step 1 (Plan)     : generateText({ ..., output: Output.object({
                       schema: { cuts: [{ where, why, severity }] }
                     })})
              :
  Step 2 (Execute)  : generateText({ ..., prompt: <text plus cuts as
                       instructions> })
                      : streams the tightened text
              :
  Step 3 (Validate) : generateText({ ..., prompt: <original plus
                       tightened>, output: Output.object({
                         schema: { meaningSurvived: boolean,
                                   warnings: [{ cut_index, reason }] }
                       })})
              :
  Response: { plan, tightened, validation }
            UI: three "thinking" stages light up one after another
```

**Seed build prompt:**

```
Build the Tighten feature. POST /api/tighten accepts { text }. Three
sequential generateText calls. Step 1 plans the cuts as Output.object.
Step 2 executes the cuts with streaming text. Step 3 validates that the
meaning survived as Output.object. Each step's output flows into the
next step's prompt. Stream all three to the client with phase markers so
the UI can light up each stage.
```

**Verify points:**

- Three distinct LLM calls are visible in the logs (use `console.log` during dev or use Vercel observability).
- Step 2 uses the structured plan from Step 1, not the raw text.
- Step 3 validates against both the original text and the tightened version.
- If validation flags any meaning loss, the UI surfaces the warning prominently.

**Why this matters:**

Without an agent loop, the feature collapses to "ask LLM to make this shorter." That is lossy. There is no accountability for keeping the meaning. The audience sees one LLM call and the lesson "agents are sequential reasoning" stays a slogan rather than a pattern they can recall.

---

### Feature 3: Voice Match (uses a voice corpus and parallel few-shot agents)

**The new skill you learn:** Parallel agents at runtime (not just at build time) plus few-shot grounding from a corpus. This is the production-grade pattern for "make AI sound like a specific person."

**Architecture**

```
client : POST /api/match { text, registers: [a, b, c] }
              :
  await Promise.all([
    generateText({ ..., system: <persona plus corpus filtered to register a> }),
    generateText({ ..., system: <persona plus corpus filtered to register b> }),
    generateText({ ..., system: <persona plus corpus filtered to register c> }),
  ])
              :
  Return { register_a: text_a, register_b: text_b, register_c: text_c }
  UI: three columns side by side
```

The important detail is that each parallel call gets **different few-shot examples** from `corpus/voice-samples.md`, filtered by the register tag. So the terse agent sees only your terse samples. The lyrical agent sees only your lyrical samples. The formal agent sees only your formal samples.

The corpus file format uses one paragraph per sample with a register tag:

```
## terse
Short. No filler. Decision: cut the third option.

## lyrical
Tuesday morning, the team gathered. The decision settled like dust...

## formal
Following our review of the three proposals, we recommend...
```

**Seed build prompt:**

```
Build the Voice Match feature. POST /api/match accepts { text,
registers: [string, string, string] }. Use Promise.all to call
generateText three times in parallel. Each call gets the persona system
prompt plus the corpus samples filtered to one register (load these
from src/corpus/voice-samples.md). Return all three rewrites in a
single response.
```

**Verify points:**

- The network tab shows the request resolves in about the time of one LLM call, not three.
- Each register's output reflects its corpus samples. The terse output is genuinely terse.
- If you swap your corpus file, the outputs change accordingly.
- All three outputs preserve the original text's meaning while shifting the style.

**Why this matters:**

Without the corpus, the feature becomes "ask LLM for three rewrites." The output sounds like three flavors of generic AI, not three flavors of you. The corpus file feels decorative instead of load-bearing. The audience learns "parallel agents at build time" again instead of "parallel agents in production."

---

## 5. The Studio Swap (the signature moment)

A **studio** is a paired set of two files: a persona file and a corpus file. You ship the product with three studios pre-loaded. The Studio Swap UI is a single dropdown. When you change the dropdown, both files get hot-swapped and Vercel redeploys. Thirty seconds later, the same URL responds in a different studio.

Recommended starter studios (you can change any of them):

| Studio | Editor persona | Corpus emphasis |
|---|---|---|
| **Strunk** | Spare, surgical, "omit needless words." Refuses to praise. | Your most terse writing (Slack one-liners, tweets, commit messages, decision logs) |
| **Pitchfork** | Spicy, opinionated, hot-take culture critic. Loves a strong verb. | Your most argumentative writing (essays, dissents, manifestos) |
| **Mentor** | Empathetic, asks Socratic questions, decision-coach energy. Never instructs, always probes. | Your most considered writing (career-decision docs, prep for 1:1s, retros) |

To implement this: keep three studios as folders under `src/studios/{name}/{persona.md, corpus.md}`. Use a top-level config file that points to the active studio. The Studio Swap UI writes to that config file and triggers a redeploy via `vercel deploy --prod`.

For the live demo, prepare three studios in advance. The "swap" is a single button click during the showcase.

---

## 6. Four worked variants (read these and steal the parts that fit)

### Variant A: Daisy, Senior PM

**Persona excerpt** in `src/persona/CLAUDE.md`:

```markdown
Editor: a senior PM who has shipped three products to a million users.
Values: customer language over PM jargon. Specifics over abstractions.
Says "what's the JTBD?" more than "what's the requirement?"
Refuses to praise vague writing. Will ask "and?" until you hit a number.
```

**Three Voice Match registers:**

- `customer-language`: rewrite as if a customer would read it.
- `tradeoff-explicit`: rewrite with every tradeoff named.
- `metric-grounded`: rewrite with every claim attached to a number.

**Tool selection:**

- `find_weak_verbs` because PMs hedge constantly.
- `check_jargon` with `domain="PM"` to catch "synergy," "rationalize," and "leverage."
- `find_buried_lede` because PRDs bury the actual ask under context.

**Studio variants:** PRD Brutalist, Customer Translator, Tradeoff Examiner.

### Variant B: Marco, Senior Engineer

**Persona excerpt:**

```markdown
Editor: a staff engineer with a reputation for cutting docs in half.
Values: precision over politeness. Specific function names over "the system."
Calls out passive voice every time. Refuses words like "essentially,"
"basically," and "simply." Asks "what specifically?" when something is
hand-wavy.
```

**Three Voice Match registers:**

- `precise`: every noun named, every action active.
- `technical-doc`: phrased the way a README would phrase it.
- `commit-message`: phrased as a conventional commit subject line plus body.

**Tool selection:**

- `measure_readability` to catch over-long sentences.
- `find_weak_verbs` (catches `is`, `does`, `provides`).
- `check_hedging` (catches `probably`, `might`, `seems`).

**Studio variants:** Doc Surgeon, README Editor, Commit Sharpener.

### Variant C: Priya, Senior Designer

**Persona excerpt:**

```markdown
Editor: a design director who edits portfolios like a magazine.
Values: hierarchy of message, single strongest claim per paragraph,
voice over volume. Says "what's the one thing?"
Refuses scattered emphasis.
```

**Three Voice Match registers:**

- `single-claim`: one idea per sentence, one strongest sentence per paragraph.
- `case-study`: situation, intervention, outcome.
- `monograph`: short prose blocks separated by white space, italics for emphasis.

**Tool selection:**

- `find_buried_lede`
- `measure_emphasis_distribution` (catches every-word-bolded text)
- `check_voice_match` against your corpus

**Studio variants:** Portfolio Director, Case Study Sharpener, Editorial Tighten.

### Variant D: Sam, Founder and Marketer

**Persona excerpt:**

```markdown
Editor: a B2B SaaS founder who has written 80 launch posts.
Values: hook in line 1, payoff in line 2, ask in the last line. No
middle filler. Refuses to bury the surprise. Calls out cliche on sight.
```

**Three Voice Match registers:**

- `tweet-thread`: line breaks every one or two sentences, hook first.
- `linkedin-post`: line 1 is the hook, story in the middle, line 1 of payoff at the end.
- `email-cold`: a subject line plus three sentences plus one ask.

**Tool selection:**

- `cliche_check`
- `find_buried_lede`
- `score_voice_match` against your corpus

**Studio variants:** Launch Day, LinkedIn Sharpener, Cold Email Coach.

---

## 7. The forty-five minute build sequence

This sequence mirrors Coach's fourteen anchor prompts. The same loop. The new concepts get inserted at steps 5, 6, and 7.

```
+00 to +03  : Personality slots
              Pick: persona, corpus paragraphs, three registers, tool
              selection, studio name, mood.

+03 to +05  : Load context
              claude-mem surfaces the Coach patterns. Confirm reuse of
              persona-loader and the route shape.

+05 to +08  : Scope and brainstorm
              The brainstorming skill: "I'm building Editor, my personal
              writing helper at a URL."
              Three features confirmed. New concepts identified.

+08 to +10  : /grillme plus /plan
              Stress-test: what if corpus is empty? What if a tool returns
              no findings? Then /plan with the writing-plans skill. Approve.

+10 to +14  : Send three subagents (one per feature)
              The same pattern as Coach. Each agent builds its route
              end-to-end. Roast pulls in tool-use scaffolding. Tighten
              gets the three-call pattern. Match gets the corpus-loader.

+14 to +22  : Wire the new concepts
              Tool use:     four tools defined, wired into Roast.
              Agent loop:   Plan, Execute, and Validate chain in Tighten.
              Voice corpus: corpus-loader.ts reads src/corpus/ and filters
                            by register.

+22 to +26  : Streaming structured UI
              Roast streams tool results as they land.
              Tighten streams the three phases.

+26 to +32  : Stitch plus shadcn plus frontend-design
              Brand the studio. Three-column Voice Match layout. Editorial
              polish.

+32 to +35  : /debug + TDD (if time permits)
              Planted bug suggestion: corpus-loader returns wrong samples
              when the register tag has trailing whitespace. If behind
              schedule, ship without this and add the test after the
              session.

+35 to +37  : Studio Swap via query param
              ?studio=strunk in the URL swaps the persona file at request
              time. No dropdown, no redeploy required. The dropdown UI is
              next-week homework.

+37 to +42  : /commit, push, Vercel
              Conventional commits. Vercel auto-deploys. Verify the URL.

+42 to +45  : Buffer + ship moment
              Three minutes of buffer absorbed slowdowns during the build.
              If still on time, post your URL in the workshop chat. If
              behind, ship a working baseline now and polish next week.
```

**Cut first if behind:** the /debug + TDD planted-bug demo (3 min saved). The Studio Swap UI was already simplified to a query param; do not add a dropdown today. Persistence (Vercel KV) is **out of scope** for the session. It is good homework for next week.

---

## 8. Recovery moves (when things go off-script)

| Symptom | Fast diagnosis | Recovery |
|---|---|---|
| Tool use loop never invokes any tools | Tool descriptions are too vague. The agent does not know when to call them. | Rewrite each tool description to start with "Use when you suspect..." |
| Tighten Step 2 ignores Step 1's plan | Prompt formatting issue. The plan is not surfaced clearly. | Pass the plan as a structured block, not as inline prose. Add "Apply each cut as instructed." |
| Voice Match outputs all sound the same | The corpus filter is not working. All three agents got the same samples. | Verify `corpus-loader.ts` filters by the register tag exactly. Add a test. |
| Stitch returns a generic palette | The mood adjective is too neutral. | Re-ask with a stronger adjective like "editorial-warm-newspaper" or "neon-brutalist." |
| Build hits forty minutes with no studio swap | Cut the swap down to a static dropdown that reads from a URL hash. | `?studio=strunk` query param swaps the persona file at request time. |
| Vercel deploy fails on the first push | Usually a missing `VERCEL_OIDC_TOKEN`. | Run `vercel link`, then run `vercel env pull .env.local`. |
| Streaming UI shows nothing | The response is JSON instead of SSE. | Switch the route to return a `ReadableStream` per the AI SDK v6 streaming docs. |

---

## 9. Definition of done

You can post your URL in the workshop chat when all of these are true:

- [ ] `your-name-editor.vercel.app` opens.
- [ ] All three features return real output (not 500 errors).
- [ ] Roast shows at least two tool-call events in the response.
- [ ] Tighten clearly shows three sequential stages in the UI.
- [ ] Voice Match outputs three visibly different rewrites.
- [ ] The Studio Swap (query param `?studio=<name>`) changes the response voice.
- [ ] Your CLAUDE.md file and voice corpus are different from anyone else's.

When all seven of these ship in forty-five minutes, you ship. Anything beyond is next-week homework.

## Next-week homework (out of scope today)

These are good ideas. They are not happening Sunday. Treat as next-week homework:

- Persistence via Vercel KV (save roasts to permanent URLs).
- Studio Swap as a dropdown UI with a redeploy trigger.
- A fourth Voice Match register.
- A fourth tool in `editor-tools.ts`.
- Streaming token-by-token UI with progressive rendering.
- Mobile-perfect responsive design.

---

## 10. After the workshop

Editor is yours. Open it three times a day for the next month. Add tools as you notice new patterns in your writing. Grow the corpus when you write something you are proud of. Build new studios for new contexts ("Sunday morning blog draft" and "Tuesday afternoon Slack reply" are different studios).

The cheatsheet from Part 1 captures the exact prompt sequence you typed. The repo has the deploy button. You can rebuild from scratch in thirty minutes if you ever want to.

The thing that lasts longer than the workshop is the loop, not the artifact.

---

*Editor brief v1, 2026-05-16, @v60samurai, Rethink enablement.*
