# AI Tutorial Workflow

> A modular AI learning workflow built on Harness Engineering principles — turn your AI coding tool into a personal tutor that gets smarter every session.

---

## What This Is

This is a structured workflow for learning AI concepts in depth, designed to run inside **Claude Code**, **Cursor**, **Codex**, or any AI environment that reads a `CLAUDE.md` file.

Instead of a single monolithic prompt, the workflow uses **Progressive Disclosure**: the core rules stay under 80 lines, and specialized skills are loaded on demand — only when you need them. This keeps the context window clean and focused.

---

## Key Features

| Feature | What It Does |
|---|---|
| 🧩 **Progressive Disclosure** | `CLAUDE.md` is the lean entry point (~80 lines). Detailed rules live in `skills/` and are loaded only when triggered |
| 🏛️ **QA Council** | Conservative + Progressive dual-role reviewers audit whether workflow rules need updating — no single point of failure |
| 🧠 **Session Handoff** | `logs/session_handoff.md` acts as a context passport — switch AI environments mid-topic without losing your place |
| 🎯 **Quiz Skill** | After learning a concept, get tested with recall / application / scenario questions to verify real understanding |
| 👤 **User Profile** | `PROFILE.md` persists your communication style and learning preferences across every session |
| 🔍 **Source Verification** | `research_methodology.md` traces claims to their original source — prevents AI hallucination from slipping through |
| 🔁 **Feedback Loop** | Link failures and rule gaps are logged, surfaced, and proposed for permanent fixes via QA Council |

---

## Quick Start

```
1. Clone or download this folder
2. Open it in Claude Code (or your preferred AI tool)
3. Fill in PROFILE.md — replace the placeholders with your preferences
4. Ask any AI/tech concept question and the workflow kicks in
5. Say "收尾" (or "wrap up") to end the session and save your progress
```

> Full usage guide → **[PLAYBOOK.md](PLAYBOOK.md)**

---

## File Structure

```
AI Tutorial/
├── CLAUDE.md                    # Entry point — loaded automatically on startup
├── PROFILE.md                   # Your learning preferences (fill this in first)
├── research_methodology.md      # Source verification protocol (loaded on demand)
├── qa_proposals.md              # QA Council proposals — review and approve here
├── check_health.sh              # System health check script
│
├── skills/                      # On-demand skill modules
│   ├── link_handling.md         # How to handle external URLs
│   ├── note_taking.md           # Save structured concept notes to notes/
│   ├── quiz.md                  # Active recall testing after learning
│   └── qa_council.md            # Dual-role workflow rule auditor
│
├── logs/
│   ├── session_handoff.md       # Context passport — updated at every session end
│   └── fetch_errors.md          # Link fetch failures (auto-logged)
│
└── notes/                       # Your saved concept notes (grows over time)
    └── YYYY-MM-DD concept.md
```

---

## Design Principles

This workflow is built on four principles from **Harness Engineering**:

1. **Progressive Disclosure** — `CLAUDE.md` is the entry point, not the whole system. Details live in `skills/` and are loaded only when triggered. Context stays clean.

2. **Feedback Loop** — Failures become rules. Link errors are logged → reviewed → promoted to permanent skill updates. The workflow gets smarter with use.

3. **Context Isolation** — Skills are loaded on demand, not at startup. Each session only carries what it needs.

4. **Memory Portability** — All state lives in files, not conversation history. `session_handoff.md` is your context passport: copy two lines to a new AI tool and pick up exactly where you left off.

---

## How the Skills Load

```
User asks a question
    │
    ├─ Recent / uncertain topic? → load research_methodology.md
    ├─ External link provided?   → load skills/link_handling.md
    ├─ "Save notes" / AI detects complete concept? → load skills/note_taking.md
    ├─ "Quiz me" / after saving notes?  → load skills/quiz.md
    ├─ Rule gap detected / "QA review"? → load skills/qa_council.md
    └─ "Wrap up"? → Gate Check → update logs/session_handoff.md
```

---

## How to Customize

**Change the AI's teaching style** → Edit `CLAUDE.md` (narrative frameworks, response style)

**Change your learning preferences** → Edit `PROFILE.md`

**Change how notes are saved** → Edit `skills/note_taking.md`

**Add a new skill** → Create `skills/your_skill.md`, add a trigger rule in `CLAUDE.md`'s Skills Index, update this README's file structure

---

## Requirements

- An AI tool that reads `CLAUDE.md` on startup (Claude Code, Cursor, Codex, etc.)
- No API keys needed for the core workflow
- `check_health.sh` requires bash (macOS / Linux)

---

## Background

This workflow was built while learning about **Harness Engineering** — the idea that `Agent = Model + Harness`, and that the quality of your AI interactions depends more on what surrounds the model than on the model itself.

The core insight: instead of writing a perfect prompt once, build a system that gets better every time it runs.
