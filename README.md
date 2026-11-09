# AI Tutorial Workflow

An interactive AI learning workflow that turns your coding agent into a personal technical tutor—complete with source-verified explanations, structured note-taking, active-recall quizzes, and continuous self-improvement.

## Workflow

```text
1. Ask a Concept or Share a Resource
   ├─ Technical question → Verify claims against primary sources (research_methodology.md)
   └─ External URL / video → Extract & process source material (skills/link_handling.md)
   │
   ▼
2. Interactive Deep-Dive & Explanation
   └─ Adapt explanation depth and analogies to your preferences in PROFILE.md
   │
   ▼
3. Structured Note Capture (skills/note_taking.md)
   └─ Distill verified concepts, mental models, and examples into notes/YYYY-MM-DD-topic.md
   │
   ▼
4. Active Recall Quiz (skills/quiz.md)
   └─ Test understanding through recall, application, and scenario-based questions
   │
   ▼
5. Session Wrap-Up & Ratchet Check
   ├─ Audit workflow gaps via Conservative + Progressive dual reviewers (skills/qa_council.md)
   └─ Save session state to logs/session_handoff.md for seamless continuation across sessions
```

## Operation

1. **Configure Profile**: Fill in your background and learning preferences in `PROFILE.md`.
2. **Start Learning**: Ask any AI/tech question or paste a link to begin an interactive study session.
3. **Save Notes & Quiz**: Ask the agent to save structured notes to `notes/` and run a comprehension quiz.
4. **Wrap Up**: Say `"wrap up"` (or `"收尾"`) at the end of a session to update `logs/session_handoff.md` and trigger the QA ratchet check.
