# AI Development Operating Rules

This repository uses specialized AI roles. Apply these rules regardless of model vendor.

## Work classification

Choose the workflow based on the input:

### Complete feature
Use when the request already contains clear scope, out-of-scope, acceptance criteria, affected modules, and risks.

Flow:
1. Plan against the existing codebase.
2. Implement the approved plan.
3. Run deterministic checks.
4. Run an independent review against the original feature file and diff.
5. Human reviews final diff.

### Lightweight feature
Use when the request is short or informal.

Flow:
1. Convert it to a compact mini-spec.
2. Define testable acceptance criteria.
3. Implement only after the requirement is coherent.
4. Run deterministic checks.
5. Independent review.
6. Human final diff review.

### Bug fix
Flow:
1. Understand reported vs expected behavior.
2. Reproduce when feasible.
3. Identify root cause.
4. Create or identify a failing regression test.
5. Apply the smallest correct fix.
6. Confirm regression test passes.
7. Run broader relevant checks.
8. Independent review.
9. Human final diff review.

## Separation of duties

The implementation agent should not be treated as the final authority on its own correctness.

The independent reviewer should begin with a review-only pass and should not modify code until explicitly asked after findings are presented.

## Definition of done

Work is not done merely because code compiles or tests pass. Completion requires:
- requested behavior implemented
- acceptance criteria traced to code and tests
- relevant deterministic checks run
- regressions considered
- unresolved uncertainty stated
- final human diff review
