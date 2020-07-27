#!/usr/bin/env bash

set -e
set -o pipefail
set -v

curl -s -X POST https://api.stackbit.com/project/5f1f3862f7d3d20015663dfb/webhook/build/pull > /dev/null
if [[ -z "${STACKBIT_API_KEY}" ]]; then
    echo "WARNING: No STACKBIT_API_KEY environment variable set, skipping stackbit-pull"
else
    npx @stackbit/stackbit-pull --stackbit-pull-api-url=https://api.stackbit.com/pull/5f1f3862f7d3d20015663dfb 
fi
curl -s -X POST https://api.stackbit.com/project/5f1f3862f7d3d20015663dfb/webhook/build/ssgbuild > /dev/null
gatsby build
curl -s -X POST https://api.stackbit.com/project/5f1f3862f7d3d20015663dfb/webhook/build/publish > /dev/null
