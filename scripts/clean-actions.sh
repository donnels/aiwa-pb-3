#!/usr/bin/env bash
# Delete old GitHub Actions workflow runs using GitHub REST API
# Usage: clean_actions [minutes] [repo]
#   minutes: optional, delete runs older than N minutes (default: delete all)
#   repo: optional, format owner/name (default: inferred from git remote)

git_clean_actions() {
  local minutes=${1:-0}
  local repo=${2:-$(git -C "${PWD}" remote get-url origin 2>/dev/null | sed -E 's|.*github\.com[:/]||;s|\.git$||')}
  
  [ -z "${GITHUB_TOKEN:-}" ] && echo "Error: GITHUB_TOKEN not set" && return 1
  [ -z "$repo" ] && echo "Error: not in git repo or repo not specified" && return 1
  
  local cutoff=""
  if [ "$minutes" -gt 0 ]; then
    cutoff=$(date -u -d "$minutes minutes ago" --iso-8601=seconds 2>/dev/null || date -u -v-${minutes}M +"%Y-%m-%dT%H:%M:%SZ")
    echo "Deleting runs older than $minutes min (before $cutoff) in $repo..."
  else
    echo "Deleting ALL runs in $repo..."
  fi
  
  local page=1 deleted=0
  while true; do
    local runs=$(curl -sf -H "Authorization: token $GITHUB_TOKEN" \
      "https://api.github.com/repos/$repo/actions/runs?per_page=100&page=$page")
    [ $? -ne 0 ] && break
    
    local count=$(echo "$runs" | jq -r '.workflow_runs | length')
    [ "$count" -eq 0 ] && break
    
    echo "$runs" | jq -r '.workflow_runs[] | "\(.id)|\(.created_at)"' | while IFS='|' read -r id created; do
      local delete=false
      [ -z "$cutoff" ] && delete=true
      [[ "$created" < "$cutoff" ]] && delete=true
      
      if [ "$delete" = true ]; then
        curl -sf -X DELETE -H "Authorization: token $GITHUB_TOKEN" \
          "https://api.github.com/repos/$repo/actions/runs/$id" >/dev/null && echo "✓ $id"
        deleted=$((deleted + 1))
      fi
    done
    
    page=$((page + 1))
  done
  
  echo "Deleted $deleted runs"
}

# Run if executed directly
[ "${BASH_SOURCE[0]}" = "${0}" ] && clean_actions "$@"

