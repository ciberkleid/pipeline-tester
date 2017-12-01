#!/bin/bash

set -o errexit

__DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"


# shellcheck source=/dev/null
source "${ROOT_FOLDER}/${TOOLS_RESOURCE}/git-resource-util.sh"
export TMPDIR=/tmp
echo "${GIT_PRIVATE_KEY}" > "${TMPDIR}/git-resource-private-key"
load_pubkey


tagNameForDelete=":refs/tags/test/${PIPELINE_VERSION}"
echo "Deleting tag [${tagNameForDelete}]"
git ls-remote --tags
git push origin "${tagNameForDelete}"
git ls-remote --tags

exit 0



