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

# Apache2のサービス状態を取得
SERVICE_STATUS=$(ssh -i "$KEY_PATH" -o ConnectTimeout=10 -o BatchMode=yes -o StrictHostKeyChecking=no ubuntu@"$AWS_EC2_HOST" \
                'systemctl is-active apache2; echo $1') || { echo "SSH command failed"; exit 1; }

# サービス状態に応じた処理
case $SERVICE_STATUS in
    active)
        echo "Test FAILURE: Apache2 service is running."
        exit 1
        ;;
    inactive)
        echo "Test SUCCESS: Apache2 service is stopped."
        exit 0
        ;;
    failed)
        echo "Apache2 service failed to start."
        exit 1
        ;;
    *)
        echo "Unexpected condition: $SERVICE_STATUS"
        exit 1
        ;;
esac
