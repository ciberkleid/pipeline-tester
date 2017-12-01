#!/bin/bash

set -o errexit

__DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# repo may contain the new repo or the prod-tagged repo
# in case it is the latter, get the latest prod tag
# if it is the former, this will return nothing
if [[ ! -z "${LATEST_TEST_TAG}" ]]; then
	echo "LATEST_TEST_TAG already set to [${LATEST_TEST_TAG}}]. Returning same value."
	echo "${LATEST_TEST_TAG}"
else
	export LATEST_TEST_TAG
	LATEST_TEST_TAG=$(git for-each-ref --sort=taggerdate --format '%(refname)' refs/tags/test | tail -1)
	LATEST_TEST_TAG="${LATEST_TEST_TAG#refs/tags/}"
	echo "${LATEST_TEST_TAG}"
fi
echo "Latest test tag is [${LATEST_TEST_TAG}]"

echo "Deleting production tag"
tagName="test/${PIPELINE_VERSION}"
if [[ "${CI}" != "CONCOURSE" ]]; then
	git push --delete origin "${tagName}"
fi
git tag -d "${tagName}"
exit 0



