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

# サーバーのURL
URL="http://php.aws"

# サーバーからのレスポンスを取得
RESPONSE=$(curl -s --connect-timeout 5 --max-time 10 $URL)

# 特定のキーワードがレスポンスに含まれているか確認
if echo "$RESPONSE" | grep -q "nginx"; then
    echo "Test SUCCESS: PHP response contains expected nginx server software version."
    exit 0
else
    echo "Test FAILURE: PHP response does not contain expected nginx server software version."
    exit 1
fi
