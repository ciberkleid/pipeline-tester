#!/bin/bash

set -o errexit

__DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Tagging the project with test tag"
echo "test/${PIPELINE_VERSION}" > "${ROOT_FOLDER}/${REPO_RESOURCE}/tag"
cp -r "${ROOT_FOLDER}/${REPO_RESOURCE}"/. "${ROOT_FOLDER}/${OUTPUT_RESOURCE}/"
