#!/usr/bin/env bash
# Pre-work validation for the Rethink enablement Sunday session.
# Outputs a ✓ or ✗ per check. Exit 0 if everything passes.

set +e

ok()  { printf "✓ %s\n" "$1"; }
bad() { printf "✗ %s\n" "$1"; FAILED=1; }
note(){ printf "○ %s\n" "$1"; }

FAILED=0

# 1. Claude Code CLI
if command -v claude >/dev/null 2>&1; then
  ok "Claude Code CLI installed"
else
  bad "Claude Code CLI not in PATH"
fi

# 2. Node 20+
NODE_RAW="$(node --version 2>/dev/null || echo "v0.0.0")"
NODE_MAJOR="$(printf "%s" "$NODE_RAW" | sed 's/v\([0-9]*\).*/\1/')"
if [ -n "$NODE_MAJOR" ] && [ "$NODE_MAJOR" -ge 20 ] 2>/dev/null; then
  ok "Node $NODE_RAW"
else
  bad "Node 20 or higher required (have $NODE_RAW)"
fi

# 3. pnpm
if command -v pnpm >/dev/null 2>&1; then
  ok "pnpm $(pnpm --version)"
else
  bad "pnpm not installed (run: npm i -g pnpm)"
fi

# 4. gh
if command -v gh >/dev/null 2>&1; then
  if gh auth status >/dev/null 2>&1; then
    ok "gh CLI authenticated"
  else
    bad "gh CLI installed but not logged in (run: gh auth login)"
  fi
else
  bad "gh CLI not installed"
fi

# 5. vercel
if command -v vercel >/dev/null 2>&1; then
  if vercel whoami >/dev/null 2>&1; then
    ok "Vercel CLI authenticated as $(vercel whoami 2>/dev/null)"
  else
    bad "Vercel CLI installed but not logged in (run: vercel login)"
  fi
else
  bad "Vercel CLI not installed (run: npm i -g vercel)"
fi

# 6. ~/.claude/CLAUDE.md exists and customized (look for template TODO markers only)
if [ -f "$HOME/.claude/CLAUDE.md" ]; then
  if grep -qE "<!-- TODO [0-9] of 5:" "$HOME/.claude/CLAUDE.md"; then
    bad "~/.claude/CLAUDE.md still has template TODO blocks unfilled"
  else
    ok "~/.claude/CLAUDE.md customized"
  fi
else
  bad "~/.claude/CLAUDE.md missing (cp claude-md-kit/CLAUDE.md.template ~/.claude/CLAUDE.md)"
fi

# 7-12. MCPs (best-effort)
if claude mcp list >/dev/null 2>&1; then
  MCP_OUT="$(claude mcp list 2>/dev/null)"
  for MCP in claude-mem context7 stitch shadcn vercel github; do
    if printf "%s" "$MCP_OUT" | grep -qi "$MCP"; then
      ok "MCP $MCP installed"
    else
      bad "MCP $MCP not installed (claude mcp add $MCP)"
    fi
  done
else
  bad "Cannot list MCPs. The claude CLI is not responding."
fi

# 11. AI Gateway readiness
if [ -n "${VERCEL_OIDC_TOKEN:-}" ] || [ -n "${AI_GATEWAY_API_KEY:-}" ]; then
  ok "AI Gateway auth ready in current shell"
else
  note "VERCEL_OIDC_TOKEN not in current shell. That is expected pre-session. On Sunday you will run 'vercel link' and 'vercel env pull .env.local' inside your build folder; the token lands in that file."
fi

echo ""
if [ "$FAILED" -eq 0 ]; then
  echo "All checks passed. You are ready for Sunday."
  exit 0
else
  echo "Some checks failed. See above. Fix the missing pieces before Sunday."
  exit 1
fi
