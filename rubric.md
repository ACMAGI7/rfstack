# Default rubric (override with .claude/rubric.md in a project)
Score each 1-5. Pass bar: every category >= 3 and average >= 4.

1. **Code quality** - simple, no dead code or bloat, clear names, matches repo conventions, typed, errors handled.
2. **Project vision fit** - does what the PRD asks, nothing out of scope, fits existing architecture.
3. **Behavior** - every "Done means" item is demonstrably met; tests cover behavior not implementation; edge cases.
4. **Safety** - no secrets in code, no destructive migrations without plan, work on a branch, nothing merged/pushed to main.
