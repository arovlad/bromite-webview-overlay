#!/bin/bash

echo "Downloading toolkit"
mv .git .git.bak &> /dev/null
git init &> /dev/null
git remote add origin https://github.com/phhusson/vendor_hardware_overlay.git &> /dev/null
git fetch --depth=1 &> /dev/null
git checkout origin/pie build &> /dev/null
rm -f -r .git
mv .git.bak .git &> /dev/null
build/build.sh
echo "Building flashable package"
mkdir build/.temp
mkdir -p build/.temp/META-INF/com/google/android
cp update-binary build/.temp/META-INF/com/google/android
echo "# Dummy file; update-binary is a shell script." > build/.temp/META-INF/com/google/android/update-script
mkdir -p build/.temp/system/addon.d
cp 99-bromite-webview.sh build/.temp/system/addon.d
mkdir -p build/.temp/vendor/overlay
cp build/treble-overlay-bromite-webview.apk build/.temp/vendor/overlay
zip -r build/BromiteSystemWebViewOverlay.zip build/.temp &> /dev/null
rm -r build/.temp
