PATH="$(npm bin):$PATH"

hasChanges() {
  git status >/dev/null # update the cache
  if git diff-index --quiet HEAD --; then
    return 1
  else
    return 0
  fi
}

configureGithubRemote() {
  local token="${GH_TOKEN:-}"

  if [ -z "${token}" ]; then
    token="${GITHUB_TOKEN:-}"
  fi

  if [ -n "${token:-}" ]; then
    git remote set-url origin "https://${token}@github.com/${1}.git"
    git config --global user.name "Brian Donovan"
    git config --global user.email "1938+eventualbuddha@users.noreply.github.com"
  fi
}
