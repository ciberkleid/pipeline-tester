#!/bin/bash

set -o errexit
set -o errtrace
set -o pipefail

export ROOT_FOLDER
ROOT_FOLDER="$( pwd )"
export REPO_RESOURCE=repo
export TOOLS_RESOURCE=tools
export OUTPUT_RESOURCE=out

echo "Root folder is [${ROOT_FOLDER}]"
echo "Repo resource folder is [${REPO_RESOURCE}]"
echo "Tools resource folder is [${TOOLS_RESOURCE}]"

# If you're using some other image with Docker change these lines
# shellcheck source=/dev/null
source /docker-lib.sh || echo "Failed to source docker-lib.sh... Hopefully you know what you're doing"
start_docker || echo "Failed to start docker... Hopefully you know what you're doing"

# Contents of pipeline.sh
export SCRIPTS_OUTPUT_FOLDER="${ROOT_FOLDER}/${REPO_RESOURCE}/ciscripts"
echo "Scripts will be copied to [${SCRIPTS_OUTPUT_FOLDER}]"

echo "Copying pipelines scripts"
cd "${ROOT_FOLDER}/${REPO_RESOURCE}" || exit
mkdir -p "${SCRIPTS_OUTPUT_FOLDER}" || echo "Failed to create the scripts output folder"
[[ -d "${ROOT_FOLDER}/${TOOLS_RESOURCE}/" ]] && \
    cp -r "${ROOT_FOLDER}/${TOOLS_RESOURCE}"/*_tag.sh "${SCRIPTS_OUTPUT_FOLDER}"/ || \
    echo "Failed to copy the scripts"

export CI="CONCOURSE"

export TERM=dumb

# Continue with task
echo "${MESSAGE}"
cd "${ROOT_FOLDER}/${REPO_RESOURCE}" || exit

# shellcheck source=/dev/null
. "${SCRIPTS_OUTPUT_FOLDER}/${SCRIPT_TO_RUN}"
