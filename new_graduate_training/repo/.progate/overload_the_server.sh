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

# ログファイルのパス
LOG_FILE="/var/log/nginx/access.log"

# チェックする最新のログエントリの数
NUMBER_OF_LINES_TO_CHECK=1

# SSH経由でリモートサーバー上のログファイルをチェック
RESPONSE=$(ssh -i "$KEY_PATH" -o ConnectTimeout=10 -o BatchMode=yes -o StrictHostKeyChecking=no ubuntu@"$AWS_EC2_HOST" "tail -n $NUMBER_OF_LINES_TO_CHECK $LOG_FILE")

# シンプルなキーワードチェックを行う
if echo "$RESPONSE" | grep -q "time:" && echo "$RESPONSE" | grep -q "remote_addr:" && echo "$RESPONSE" | grep -q "request_method:"; then
    echo "SUCCESS: The latest log entry seems to be in the specified format."
    exit 0
else
    echo "FAILED: The latest log entry does not match the specified format."
    exit 1
fi
