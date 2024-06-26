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

# df コマンドの実行結果からルートファイルシステムのディスク容量と使用量を取得
DISK_INFO=$(ssh -i "$KEY_PATH" -o ConnectTimeout=10 -o BatchMode=yes -o StrictHostKeyChecking=no ubuntu@"$AWS_EC2_HOST" \
                'df -h | grep "/dev/root"')

# ディスク容量と使用量を抽出
DISK_TOTAL=$(echo "$DISK_INFO" | awk '{print $2}')
DISK_USED=$(echo "$DISK_INFO" | awk '{print $3}')

# ディスク容量と使用量が期待値と一致するか確認
if [[ "$DISK_TOTAL" == "$ANSWER_CHECK_SERVER_STATUS_DISK_TOTAL_GB" ]] && [[ "$DISK_USED" == "$ANSWER_CHECK_SERVER_STATUS_DISK_USED_GB" ]]; then
    echo "Test SUCCESS: Disk status matches the expected values."
    exit 0
else
    echo "Test FAILURE: Disk status does not match the expected values."
    echo "Expected Total: $DISK_TOTAL, Used: $DISK_USED"
    echo "Got Total: $ANSWER_CHECK_SERVER_STATUS_DISK_TOTAL_GB, Used: $ANSWER_CHECK_SERVER_STATUS_DISK_USED_GB"
    exit 1
fi
