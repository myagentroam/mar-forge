#!/usr/bin/env bash
set -euo pipefail

die() {
  printf 'release: %s\n' "$*" >&2
  exit 1
}

command -v git >/dev/null 2>&1 || die "git is required"

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$repo_root"

[[ "$(git branch --show-current)" == "develop" ]] || die "run from develop"
[[ -z "$(git status --porcelain)" ]] || die "worktree must be clean"
[[ -n "$(git config --local user.name)" && -n "$(git config --local user.email)" ]] || die "local Git identity is required"

lock_dir="$(git rev-parse --git-path forge-release.lock)"
mkdir "$lock_dir" 2>/dev/null || die "another release is in progress"
tmp_dir=""
cleanup() {
  if [[ -n "$tmp_dir" ]]; then
    git worktree remove --force "$tmp_dir" >/dev/null 2>&1 || true
  fi
  rmdir "$lock_dir" 2>/dev/null || true
}
trap cleanup EXIT

release_sha="$(git rev-parse HEAD)"
version="$(tr -d '[:space:]' < VERSION)"
[[ "$version" =~ ^(0|[1-9][0-9]*)\.(0|[1-9][0-9]*)\.(0|[1-9][0-9]*)$ ]] || die "VERSION must be strict SemVer"
next_version="${BASH_REMATCH[1]}.${BASH_REMATCH[2]}.$((BASH_REMATCH[3] + 1))"

git fetch origin --prune
[[ "$(git rev-parse origin/develop)" == "$release_sha" ]] || die "develop must be pushed and synchronized"
if git show-ref --verify --quiet refs/remotes/origin/main; then
  git merge-base --is-ancestor origin/main "$release_sha" || die "main is not an ancestor of this release"
fi

printf 'Publishing main at %s (version %s)\n' "$release_sha" "$version"
git push origin "$release_sha:refs/heads/main"

tmp_dir="$(mktemp -d)"
git worktree add --detach "$tmp_dir" "$release_sha" >/dev/null
printf '%s\n' "$next_version" > "$tmp_dir/VERSION"
git -C "$tmp_dir" add VERSION
git -C "$tmp_dir" commit -m "chore: bump version to $next_version" >/dev/null
bump_sha="$(git -C "$tmp_dir" rev-parse HEAD)"
git push origin "$bump_sha:refs/heads/develop"

git fetch origin develop main
if [[ "$(git rev-parse HEAD)" == "$release_sha" && -z "$(git status --porcelain)" ]]; then
  git merge --ff-only origin/develop >/dev/null
else
  printf 'Released; local develop was not synchronized because its state changed\n' >&2
fi
printf 'Published main; develop is now %s (%s)\n' "$next_version" "$bump_sha"
