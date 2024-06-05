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

# 指定されたURLにHTTPリクエストを送信し、レスポンスを取得
URL="http://$AWS_EC2_HOST/test.php"
RESPONSE=$(curl -o /dev/null -s -w "%{http_code}\n" "$URL")

# ステータスコードが200であるかどうかを確認
if [ "$RESPONSE" -eq 200 ]; then
    echo "Test SUCCESS: Server is accessible."
    exit 0
else
    echo "Test FAILURE: Server is not accessible. Response code: $RESPONSE"
    exit 1
fi
