---
name: planning-repo
description: Read, reference, or edit plans and research docs in the jhillyerd/planning Forgejo repo. Use when asked to read, review, update, write, or commit a plan under homelab/plans, inbucket/plans, or misc/research; when given a forgejo.bytemonkey.org/jhillyerd/planning URL; or when a task says "the plan says..." / "per the plan".
---

# Planning repo (jhillyerd/planning)

Forgejo repo of project plans and research notes.

- Browse: `https://forgejo.bytemonkey.org/jhillyerd/planning`
- SSH remote (for edits/pushes): `ssh://git@git.bytemonkey.org:222/jhillyerd/planning.git`
- Branches: `main` (default), plus feature branches such as `consul`. Enumerate with
  `curl -sL https://forgejo.bytemonkey.org/api/v1/repos/jhillyerd/planning/branches`

## Read plans with curl, not the local checkout

**Always read plan content over HTTPS with `curl`, even if a local copy exists.** This guarantees the
plan you and the user are discussing is the same one. A local checkout may be dirty, stale, or checked
out on a different branch.

```bash
curl -sL https://forgejo.bytemonkey.org/jhillyerd/planning/raw/branch/<branch>/<path>
```

Use `/raw/branch/...` (file bytes), not `/src/branch/...` (HTML page view).

**Do not use `web_search` or `fetch_content` for this host** — `forgejo.bytemonkey.org` resolves to a
private LAN address, which those tools block via their SSRF guard, regardless of repo visibility.
Only `bash` + `curl` reaches it. The repo is public, so no token is needed.

### Find files without cloning

```bash
# Recursive file list for a branch
curl -sL "https://forgejo.bytemonkey.org/api/v1/repos/jhillyerd/planning/git/trees/<branch>?recursive=true" \
  | grep -o '"path":"[^"]*"'
```

Known paths:

| Path | Contents |
|---|---|
| `homelab/plans/` | Active homelab plans |
| `homelab/plans/completed/` | Finished homelab plans |
| `inbucket/plans/` | Inbucket plans |
| `misc/research/` | Research notes |

## Making changes

Reading goes to the server; writing goes through the local checkout, usually
`~/devel/planning`. Before editing:

1. `git -C ~/devel/planning status` — confirm the working tree is clean and check the current branch.
   If it is dirty, do not overwrite work in progress; ask the user.
2. `git -C ~/devel/planning fetch origin` and reconcile the target branch with `origin`.
3. Read the file with `curl` first to establish the server-side baseline, then apply the edit to the
   local file. If local and server content differ, surface the difference instead of silently picking one.
4. Commit and push to the intended branch, then `curl` again to confirm the change landed.

Do not create a fresh clone in `/tmp` to make edits — that discards the user's local history and branch
context. Reserve a throwaway clone for read-only inspection when no checkout exists.
