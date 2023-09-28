#!/bin/bash

set -euxo pipefail

cd $(dirname $0)

shellcheck -o all ./msync

gem install bashcov -N

rm -rf coverage

bashcov -- ./msync --help || true
bashcov --mute -- ./msync rsync://rsync.cyberbits.eu/ruby/ /tmp/msync/ --dry-run --temporary-directory /tmp
bashcov -- ./msync rsync://rsync.cyberbits.eu/archlinux/ /tmp/msync/ --dry-run --quiet --last-update-url https://mirror.cyberbits.eu/archlinux/lastupdate --last-update-sync lastsync --random-delay 1 --warning-timeout 30 --temporary-directory /tmp
