---
description: Set up context for handling partial PR acceptance after discussion
---

# Partial PR Acceptance Context

You have been discussing a PR with the user and have decided that some changes should be accepted
while others should be rejected. The decision to cherry-pick and close (rather than asking for more
revisions) has already been made. This command establishes context for executing that decision.

## User's Additional Input (if provided)

"$ARGUMENTS"

## Best Practices

These principles guide partial PR acceptance:

- Cherry-pick acceptable changes rather than asking for endless revisions when scope is the issue
- Use `Co-authored-by: Name <email>` trailer for attribution (use contributor's GitHub email)
- Contributors receive contribution graph credit from co-authored commits
- Closed PRs with clear explanation and proper attribution maintain goodwill
- Thank the contributor and be specific about what was accepted vs rejected
- Reference the new commit in the close message so they can verify their attribution
- If the project has a CONTRIBUTING.md with scope guidelines, reference it in the close message

## Why Scope Matters

When a PR is merged, the maintainer takes on indefinite responsibility for that code: bugs,
documentation, compatibility, and future enhancements. Rejecting out-of-scope content is not
personal; it is responsible maintenance.

## Anti-Patterns to Avoid

- Merging out of guilt for how much work the contributor put in
- Being vague about why parts were rejected
- Leaving the PR open indefinitely instead of closing promptly
- Ignoring the PR entirely (even rejection deserves acknowledgment)

## Co-Author Format

There must be a blank line between the commit message body and the trailer:

```txt
Commit subject line

Commit body explaining the changes.

Co-authored-by: Name <email@example.com>
```

For contributor email, check their GitHub profile. If they use a private email, use their noreply
address. GitHub has two formats depending on account age:

- Accounts after July 2017: `ID+username@users.noreply.github.com`
- Older accounts: `username@users.noreply.github.com`

The ID-based format is preferred as it survives username changes.

## Your Task

Based on the prior discussion about this PR, propose:

1. **Changes to keep**: Which specific changes/commits should be accepted and why
2. **Changes to reject**: Which parts are out of scope and the reasoning
3. **Draft close message**: A respectful message that thanks the contributor, explains what was
   accepted, why other parts were not accepted, and references the attributed commit

Present this proposal and wait for user approval before taking any action. The user may want to
discuss or refine the proposal before proceeding.
