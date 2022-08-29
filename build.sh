#!/bin/bash

echo "Downloading toolkit"
mv .git .git.bak &> /dev/null
git init &> /dev/null
git remote add origin https://github.com/phhusson/vendor_hardware_overlay.git &> /dev/null
git fetch --depth=1 &> /dev/null
git checkout origin/pie build &> /dev/null
rm -f -r .git
mv .git.bak .git &> /dev/null
cd build
./build.sh
