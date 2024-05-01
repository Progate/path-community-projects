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

# SSHでリモートサーバーに接続し、プロセスの数を確認
PROCESS_COUNT=$(ssh -i "$KEY_PATH" -o ConnectTimeout=10 -o BatchMode=yes -o StrictHostKeyChecking=no ubuntu@"$AWS_EC2_HOST" \
                'ps aux | wc -l | awk '\''{print $1-1}'\''')

# プロセス数の確認（誤差±5を許容）
LOWER_BOUND=$((ANSWER_CHECK_SERVER_STATUS_PS_COUNT - 5))
UPPER_BOUND=$((ANSWER_CHECK_SERVER_STATUS_PS_COUNT + 5))

# プロセス数の確認
if [ "$PROCESS_COUNT" -ge "$LOWER_BOUND" ] && [ "$PROCESS_COUNT" -le "$UPPER_BOUND" ]; then
    echo "Test SUCCESS: The process count matches the expected value."
    exit 0
else
    echo "Test FAILURE: The process count does not match the expected value."
    echo "Expected: $PROCESS_COUNT, but got: $ANSWER_CHECK_SERVER_STATUS_PS_COUNT"
    exit 1
fi
