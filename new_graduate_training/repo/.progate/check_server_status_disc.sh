#!/bin/bash

ENV_FILE=".env"

# .env ファイルから環境変数を読み込む
if [ -f "$ENV_FILE" ]; then
    export $(cat "$ENV_FILE" | xargs)
else
    echo ".env file not found"
    exit 1
fi

# df コマンドの実行結果からルートファイルシステムのディスク容量と使用量を取得
DISK_INFO=$(ssh -i $KEY_PATH -o ConnectTimeout=10 -o BatchMode=yes -o StrictHostKeyChecking=no ubuntu@$AWS_EC2_HOST \
                'df -h | grep "/dev/root"')

# ディスク容量と使用量を抽出
DISK_TOTAL=$(echo $DISK_INFO | awk '{print $2}')
DISK_USED=$(echo $DISK_INFO | awk '{print $3}')

# ディスク容量と使用量が期待値と一致するか確認
if [[ "$DISK_TOTAL" == "$ANSWER_CHECK_SERVER_STATUS_DISK_TOTAL" ]] && [[ "$DISK_USED" == "$ANSWER_CHECK_SERVER_STATUS_DISK_USED" ]]; then
    echo "Test SUCCESS: Disk status matches the expected values."
    exit 0
else
    echo "Test FAILURE: Disk status does not match the expected values."
    echo "Expected Total: $DISK_TOTAL, Used: $DISK_USED"
    echo "Got Total: $ANSWER_CHECK_SERVER_STATUS_DISK_TOTAL, Used: $ANSWER_CHECK_SERVER_STATUS_DISK_USED"
    exit 1
fi
