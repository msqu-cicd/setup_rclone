#!/bin/sh
set -eu
echo ::group::Downloading Rclone $version for $RUNNER_OS $RUNNER_ARCH
if [ $RUNNER_OS = macOS ]; then os=osx; else os=linux; fi
if [ $RUNNER_ARCH = ARM64 ]; then arch=arm64; else arch=amd64; fi
if [ -z "${FORGEJO_ACTIONS+x}" ] || [ -z "${GITEA_ACTIONS+x}" ]; then
	# in forgejo or gitea runner
    wget -q https://github.com/rclone/rclone/releases/download/$version/rclone-$version-$os-$arch.zip
else
	# in github runner
    wget -q $GITHUB_SERVER_URL/rclone/rclone/releases/download/$version/rclone-$version-$os-$arch.zip
fi
unzip -jq rclone-$version-$os-$arch.zip */rclone -d Rclone
rm rclone-$version-$os-$arch.zip
echo ::endgroup::
