#!/bin/bash

set -eu

PROJECT_DIR=$(dirname "$(cd "$(dirname "$0")"; pwd)")
QUESTIONS_SH_FILEPATH="${PROJECT_DIR}/questions.sh"
if [ ! -f "$QUESTIONS_SH_FILEPATH" ] ; then
    echo "${QUESTIONS_SH_FILEPATH} is not found"
    exit 1
fi

# Load variables
# shellcheck disable=SC1090
. "$QUESTIONS_SH_FILEPATH"

# SSH接続を試みるコマンド
if ssh -i "$KEY_PATH" -o ConnectTimeout=10 -o BatchMode=yes -o StrictHostKeyChecking=no ubuntu@"$AWS_EC2_HOST" 'echo "SSH connection successful."'; then
    echo "SSH connection test: SUCCESS"
    exit 0
else
    echo "SSH connection test: FAILURE"
    exit 1
fi
