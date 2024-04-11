#!/bin/bash

ENV_FILE=".env"

# .env ファイルから環境変数を読み込む
if [ -f "$ENV_FILE" ]; then
    export $(cat "$ENV_FILE" | xargs)
else
    echo ".env file not found"
    exit 1
fi

# 指定されたURLにHTTPリクエストを送信し、レスポンスを取得
URL="http://$AWS_EC2_HOST/index.php"
RESPONSE=$(curl -o /dev/null -s -w "%{http_code}\n" $URL)

# ステータスコードが200であるかどうかを確認
if [ "$RESPONSE" -eq 200 ]; then
    echo "Test SUCCESS: Server is accessible."
    exit 0
else
    echo "Test FAILURE: Server is not accessible. Response code: $RESPONSE"
    exit 1
fi