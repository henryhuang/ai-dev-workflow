# Repository-wide AI development rules

- Treat the user's requirement, feature file, and acceptance criteria as the source of truth.
- Do not silently invent product requirements.
- Keep changes narrowly scoped to the requested work.
- Avoid unrelated refactors and formatting churn.
- Prefer existing project patterns over introducing new abstractions.
- Before changing code, inspect the relevant implementation and tests.
- Prefer deterministic validation (lint, typecheck, tests, build) over verbal claims.
- Never claim a check passed unless it was actually run successfully.
- Tests should validate behavior required by the specification, not merely reproduce implementation details.
- For bug fixes, reproduce first when feasible and prefer a regression test that fails before the fix.
- For reviews, inspect the actual git diff and map findings back to requirements or acceptance criteria.
- Surface uncertainty explicitly.
- Preserve backward compatibility unless the requirement intentionally changes behavior.
- Security, data integrity, concurrency, migration, API contract, and error-handling risks should be called out when relevant.
- Final human review of the diff is expected before commit.
