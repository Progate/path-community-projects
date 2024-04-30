#!/bin/bash

set -eu

ENV_FILE="questions.env"

# .env ファイルから環境変数を読み込む
if [ -f "$ENV_FILE" ]; then
    export $(xargs < "$ENV_FILE")
else
    echo "questions.env file not found"
    exit 1
fi

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
