#!/bin/bash

ENV_FILE=".env"

# .env ファイルから環境変数を読み込む
if [ -f "$ENV_FILE" ]; then
    export $(cat "$ENV_FILE" | xargs)
else
    echo ".env file not found"
    exit 1
fi

# Apache2のサービス状態を取得
SERVICE_STATUS=$(ssh -i $KEY_PATH -o ConnectTimeout=10 -o BatchMode=yes -o StrictHostKeyChecking=no ubuntu@$AWS_EC2_HOST \
                'systemctl is-active apache2')

# サービスが停止しているかどうかを確認
if [ "$SERVICE_STATUS" = "inactive" ]; then
    echo "Test SUCCESS: Apache2 service is stopped."
    exit 0
else
    echo "Test FAILURE: Apache2 service is not stopped. Current status: $SERVICE_STATUS"
    exit 1
fi
