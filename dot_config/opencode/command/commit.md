---
description: Commit and push changes
---

# Prepare

For Rust projects:

1. Run `cargo fmt` to format the code.
2. Run `cargo clippy --all-targets --all-features -- -D warnings` to check for
   linting issues.

# Commit and Push Changes

Commit all staged and unstaged changes with a descriptive commit message, then
push to the remote repository.

IMPORTANT: Always use `git push --set-upstream origin <branch-name>` to push
changes. This ensures the local branch is properly tracked by the remote branch,
even if the branch already exists on the remote.
