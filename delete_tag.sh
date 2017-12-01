#!/bin/bash

set -o errexit

__DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# repo may contain the new repo or the prod-tagged repo
# in case it is the latter, get the latest prod tag
# if it is the former, this will return nothing
#if [[ ! -z "${LATEST_TEST_TAG}" ]]; then
#	echo "LATEST_TEST_TAG already set to [${LATEST_TEST_TAG}}]. Returning same value."
#	echo "${LATEST_TEST_TAG}"
#else
#	export LATEST_TEST_TAG
#	LATEST_TEST_TAG=$(git for-each-ref --sort=taggerdate --format '%(refname)' refs/tags/test | tail -1)
#	LATEST_TEST_TAG="${LATEST_TEST_TAG#refs/tags/}"
#	echo "${LATEST_TEST_TAG}"
#fi
#echo "Latest test tag is [${LATEST_TEST_TAG}]"

#echo "Run: git tag"
#git tag
#echo
#
#tagName="test/${PIPELINE_VERSION}"
#echo "Deleting test tag [${tagName}]"

#git push --delete origin "${tagName}"

#git tag -d "${tagName}"

#echo "Run: git tag"
#git tag
#echo

mkdir -p ~/.ssh
echo $GIT_PRIVATE_KEY > ~/.ssh/id_rsa
ssh-keyscan -H github.com >> ~/.ssh/known_hosts

tagNameForDelete=":refs/tags/test/${PIPELINE_VERSION}"

git push origin "${tagNameForDelete}"

exit 0



