#!/sbin/sh
#
# ADDOND_VERSION=2
#
# /system/addon.d/99-bromite-webview-overlay.sh
# During an Android upgrade, this script backs up treble-overlay-bromite-webview.apk,
# located in either /vendor/overlay/ or /system/product/overlay/,
# the partitions are formatted and reinstalled, then the file is restored.
#
# Adapted from 50-cm.sh
#

. /tmp/backuptool.functions

list_files() {
cat <<EOF
/vendor/overlay/treble-overlay-bromite-webview.apk
/system/product/overlay/treble-overlay-bromite-webview.apk
EOF
}

case "$1" in
  backup)
    list_files | while read FILE DUMMY; do
      backup_file $S/"$FILE"
    done
  ;;
  restore)
    list_files | while read FILE REPLACEMENT; do
      R=""
      [ -n "$REPLACEMENT" ] && R="$S/$REPLACEMENT"
      [ -f "$C/$S/$FILE" ] && restore_file $S/"$FILE" "$R"
    done
  ;;
  pre-backup)
    # Stub
  ;;
  post-backup)
    # Stub
  ;;
  pre-restore)
    # Stub
  ;;
  post-restore)
    # Stub
  ;;
esac

