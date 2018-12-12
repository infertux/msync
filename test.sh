#!/bin/bash

set -euxo pipefail

cd $(dirname $0)

gem install bashcov -N

rm -rf coverage
bashcov -- ./msync rsync://rsync.samba.org/rsyncftp/ /tmp/rsync/ --dry-run
