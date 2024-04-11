#!/bin/bash

ENV_FILE=".env"

# .env ファイルから環境変数を読み込む
if [ -f "$ENV_FILE" ]; then
    export $(cat "$ENV_FILE" | xargs)
else
    echo ".env file not found"
    exit 1
fi

# サーバーのURL
URL="http://php.aws"

# サーバーからのレスポンスを取得
RESPONSE=$(curl -s $URL)

# 特定のキーワードがレスポンスに含まれているか確認
if echo "$RESPONSE" | grep -q "nginx/1.18.0"; then
    echo "Test SUCCESS: PHP response contains expected nginx server software version."
    exit 0
else
    echo "Test FAILURE: PHP response does not contain expected nginx server software version."
    exit 1
fi