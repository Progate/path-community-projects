#!/bin/bash

ENV_FILE=".env"

# .env ファイルから環境変数を読み込む
if [ -f "$ENV_FILE" ]; then
    export $(cat "$ENV_FILE" | xargs)
else
    echo ".env file not found"
    exit 1
fi

# SSH接続を試みるコマンド
if ssh -i $KEY_PATH -o ConnectTimeout=10 -o BatchMode=yes -o StrictHostKeyChecking=no ubuntu@$AWS_EC2_HOST 'echo "SSH connection successful."'; then
    echo "SSH connection test: SUCCESS"
    exit 0
else
    echo "SSH connection test: FAILURE"
    exit 1
fi
