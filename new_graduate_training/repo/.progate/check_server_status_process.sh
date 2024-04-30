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
