#!/bin/sh
set -eu
if [ "$version" = latest ]
then
  if ! command -v gh &>/dev/null; then
    # gh not found
    latest_version=$(curl -s https://api.github.com/repos/rclone/rclone/releases/latest | jq -r .tag_name)
    echo "version=$latest_version" >> $GITHUB_OUTPUT
  else
    # gh found
    latest_version=$(gh api repos/rclone/rclone/releases/latest -q .tag_name)
    echo "version=$latest_version" >> $GITHUB_OUTPUT
  fi
else
  echo "version=$version" >> $GITHUB_OUTPUT
fi
