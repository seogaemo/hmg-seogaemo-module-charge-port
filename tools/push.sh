#!/bin/sh
# Install the packed module on a head unit reachable over adb (NEMESIS root).
set -eu
cd "$(dirname "$0")/.."
set -- $(python3 tools/pack.py)
file=$1
digest=$2
adb shell mkdir -p /data/local/tmp/hsm
adb push "$file" "/data/local/tmp/hsm/$digest.hsm"
adb shell cp /system/xbin/nemesis /data/local/tmp/nemesis-d
adb shell /data/local/tmp/nemesis-d root -c "'/system/bin/sh /data/nemesis/apps/hmg-seogaemo/bin/hmg-seogaemo-root module install $digest'"
