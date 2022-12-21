#!/bin/bash
set -e

if [ ! -f build/build.sh ]; then
echo "Downloading toolkit"
git clone --depth=1 https://github.com/phhusson/vendor_hardware_overlay.git
( cd vendor_hardware_overlay && git checkout origin/pie build && mv build .. )
fi

echo "Building overlay APK"
( cd build && ./build.sh ../BromiteWebView/Android.mk )

echo "Building flashable package (zip)"
mkdir build/.temp
mkdir -p build/.temp/META-INF/com/google/android
cp update-binary build/.temp/META-INF/com/google/android
echo "# Dummy file; update-binary is a shell script." > build/.temp/META-INF/com/google/android/updater-script
mkdir -p build/.temp/system/addon.d
cp 99-bromite-webview.sh build/.temp/system/addon.d
mkdir -p build/.temp/vendor/overlay
cp build/treble-overlay-bromite-webview.apk build/.temp/vendor/overlay
( cd build/.temp && zip -r - . > ../BromiteSystemWebViewOverlay.zip . ) &> /dev/null
rm -r build/.temp

echo "Building Magisk module (zip)"
mkdir build/.temp
mkdir -p build/.temp/META-INF/com/google/android
curl -sL https://github.com/topjohnwu/Magisk/raw/master/scripts/module_installer.sh > build/.temp/META-INF/com/google/android/update-binary
test -s build/.temp/META-INF/com/google/android/update-binary
echo "#MAGISK" > build/.temp/META-INF/com/google/android/updater-script
mkdir -p build/.temp/system/vendor/overlay
cp build/treble-overlay-bromite-webview.apk build/.temp/system/vendor/overlay
cp module.prop build/.temp/
( cd build/.temp && zip -r - . > ../BromiteSystemWebViewMagisk.zip . ) &> /dev/null
rm -r build/.temp
