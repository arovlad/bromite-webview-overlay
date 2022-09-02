# Bromite SystemWebView Overlay

In order for Bromite SystemWebView to be [installed](https://github.com/bromite/bromite/wiki/Installing-SystemWebView), it must be one of the supported webviews hardcoded in the framework package. Since ROMs typically don't include Bromite SystemWebView among them, the community has developed some methods that allow the framework to be patched in order to include it.

This package makes use of a [resource overlay](https://source.android.com/docs/core/architecture/rros) to replace the list of hardcoded webviews with one that also includes the Bromite WebView. I personally find this method more straightforward and elegant, as it does not require root access nor the tedious process of installing Magisk modules or patching the system framework itself manually — if anything breaks the package can simply be removed. Moreover, the WebView itself does not need to be installed as a system app and has no potential risk of breaking SafetyNet.

## Compatibility

This method was tested on LineageOS 19.1 for MicroG based on Android 12.1. **Currently, testing has NOT been done on any other Android versions.**

## Prerequisites

* `adb`
* Support for rooted debugging (enabled via *Settings > Developer options > Rooted debugging*) or a recovery that supports ADB

## Installation

Restart ADB with root privileges

`adb root`

Mount the vendor folder as read-write

`adb shell mount -o rw,remount /vendor`

Copy the required package to the overlay folder

`adb push treble-overlay-bromite-webview.apk /vendor/overlay`

Verify if the correct permissions are set (optional)

`adb shell stat /vendor/overlay/treble-overlay-bromite-webview.apk | grep "0644"`

After the file has been pushed, reboot the device

`adb reboot`

After rebooting you can verify if the overlay has been successfully installed (optional)

`adb shell dumpsys webviewupdate`

If everything is ok, you should see the following message:

`org.bromite.webview is NOT installed.`

[Download the latest Bromite SystemWebView release](https://www.bromite.org/system_web_view) and install it as you would a regular app. 

Lastly, navigate to *Settings > Developer options > WebView implementation* and select the appropriate package.

### Work Profile

Be aware that if you have a work profile enabled you also need to install the package from the work profile a second time (usually via de Work Files app), otherwise work apps that rely on the WebView component will refuse to work or crash altogether. 

To ensure that the package is installed for both profiles install the package via ADB.

`adb install <package-name>.apk`

### Alternative location (only for Android 11+)

Mount the system as read-write

`adb shell mount -o rw,remount /`

Copy the required package to the overlay folder

`adb push treble-overlay-bromite-webview.apk /system/product/overlay`

Verify if the correct permissions are set (optional)

`adb shell stat /system/product/overlay/treble-overlay-bromite-webview.apk | grep "0644"`

## Building

The following dependencies are required:

* `git`
* `xmlstarlet`
* `aapt`
* `apktool`

Run the build script

`./build.sh`

Alternatively, you can read a more in-depth guide [here](https://github.com/phhusson/treble_experimentations/wiki/How-to-create-an-overlay%3F).

## Credits

* [Pierre-Hugues Husson](https://github.com/phhusson) for the guide and toolkit



