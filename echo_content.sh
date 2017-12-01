#!/bin/bash

set -o errexit

__DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"


cat manifest.yml

git tag

if [[ ! -z "${LATEST_PROD_TAG}" ]]; then
    echo "LATEST_PROD_TAG already set to [${LATEST_PROD_TAG}}]. Returning same value."
	echo "${LATEST_PROD_TAG}"
else
	latestProdTag=$(git for-each-ref --sort=taggerdate --format '%(refname)' refs/tags/prod | tail -1)
	export LATEST_PROD_TAG
	LATEST_PROD_TAG="${latestProdTag#refs/tags/}"
	echo "${LATEST_PROD_TAG}"
fi

git branch
git checkout "${LATEST_PROD_TAG}"
git branch

exit 0



