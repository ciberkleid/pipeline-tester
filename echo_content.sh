#!/bin/bash

set -o errexit

__DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"


cat "${REPO_RESOURCE}/manifest.yml"

exit 0



