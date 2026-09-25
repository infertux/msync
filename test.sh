#!/bin/bash

set -euxo pipefail

cd $(dirname $0)

# Run Shellcheck first
shellcheck -o all ./msync

# Remove any previous coverage
rm -rf coverage

# Test with --help
bashcov -- ./msync --help || true

# Test happy path
bashcov --mute -- ./msync rsync://rsync.cyberbits.eu/ruby/ /tmp/msync/ --dry-run --temporary-directory /tmp

# Test with SSL/TLS enabled
bashcov --mute -- ./msync --ssl rsync://rsync.cyberbits.eu/ruby/ /tmp/msync/ --dry-run --temporary-directory /tmp

# Test with --last-update-url
bashcov -- ./msync rsync://rsync.cyberbits.eu/archlinux/ /tmp/msync/ --dry-run --quiet --last-update-url https://mirror.cyberbits.eu/archlinux/lastupdate --last-update-sync lastsync --random-delay 1 --warning-timeout 30 --temporary-directory /tmp
