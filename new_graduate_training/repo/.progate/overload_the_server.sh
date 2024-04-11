#!/bin/bash

ENV_FILE=".env"

# .env ファイルから環境変数を読み込む
if [ -f "$ENV_FILE" ]; then
    export $(cat "$ENV_FILE" | xargs)
else
    echo ".env file not found"
    exit 1
fi

# ログファイルのパス
LOG_FILE="/var/log/nginx/access.log"

# チェックする最新のログエントリの数
NUMBER_OF_LINES_TO_CHECK=1

# 指定されたフォーマットに基づくパターン
PATTERN="time:(.*)\tremote_addr:(.*)\trequest_method:(.*)\trequest_length:(.*)\trequest_uri:(.*)\thttps:(.*)\turi:(.*)\tquery_string:(.*)\tstatus:(.*)\tbytes_sent:(.*)\tbody_bytes_sent:(.*)\treferer:(.*)\tuseragent:(.*)\tforwardedfor:(.*)\trequest_time:(.*)\tupstream_response_time:(.*)\thost:(.*)"

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