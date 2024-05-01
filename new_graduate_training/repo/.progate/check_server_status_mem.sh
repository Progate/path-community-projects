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

# top コマンドの実行結果からメモリ情報を取得
MEMORY_INFO=$(ssh -i "$KEY_PATH" -o ConnectTimeout=10 -o BatchMode=yes -o StrictHostKeyChecking=no ubuntu@"$AWS_EC2_HOST" \
                'top -b -n 1 | grep "MiB Mem"')

# 総メモリと使用中のメモリを抽出
MEM_TOTAL=$(echo "$MEMORY_INFO" | awk '{print $4}')
MEM_USED=$(echo "$MEMORY_INFO" | awk '{print $8}')

# 期待値との差の絶対値が5以下かどうかをチェックする関数
check_range() {
    local diff
    diff=$(echo "$1 - $2" | bc)
    if [ "$(echo "if (${diff#-} <= 5) 1 else 0" | bc)" -eq 1 ]; then
        return 0 # true
    else
        return 1 # false
    fi
}

# 総メモリと使用中のメモリが期待値と一致するか（±5の範囲内）確認
if check_range "$MEM_TOTAL" "$ANSWER_CHECK_SERVER_STATUS_MEM_TOTAL_MIB" && check_range "$MEM_USED" "$ANSWER_CHECK_SERVER_STATUS_MEM_USED_MIB"; then
    echo "Test SUCCESS: Memory status matches the expected values within the tolerance range."
else
    echo "Test FAILURE: Memory status does not match the expected values within the tolerance range."
    echo "Expected Total: $ANSWER_CHECK_SERVER_STATUS_MEM_TOTAL_MIB MiB, Used: $ANSWER_CHECK_SERVER_STATUS_MEM_USED_MIB MiB"
    echo "Got Total: $MEM_TOTAL MiB, Used: $MEM_USED MiB"
    exit 1
fi
