# Bromite SystemWebView Overlay

In order for Bromite SystemWebView to be [installed](https://github.com/bromite/bromite/wiki/Installing-SystemWebView), it must be one of the supported webviews hardcoded in the framework package. Since ROMs typically don't include Bromite SystemWebView among them, the community has developed some methods that allow the framework to be patched in order to include it.

This package makes use of a [resource overlay](https://source.android.com/docs/core/architecture/rros) to replace the list of hardcoded webviews with one that also includes the Bromite WebView. I personally find this method more straightforward and elegant, as it does not require root access nor the tedious process of installing Magisk modules or patching the system framework itself manually — if anything breaks the package can simply be removed. Moreover, the WebView itself does not need to be installed as a system app and has no potential risk of breaking SafetyNet.

![The WebView implementation settings with the Bromite SystemWebView Overlay installed](screenshot.png)

## Prerequisites

* Treble-enabled ROM ([How to check?](https://github.com/phhusson/treble_experimentations/wiki/Frequently-Asked-Questions-%28FAQ%29#how-can-i-check-if-my-device-is-treble-enabled))
* Custom recovery **(preferred)**, support for rooted debugging (enabled via *Settings > Developer options > Rooted debugging*) or root access

Although this method should work on all Android versions that support Bromite and it's WebView, **currently testing has only been done on LineageOS 19.1 for MicroG based on Android 12.1**.

## Installation

* Reboot device into recovery mode, either from the power menu, via a device-specific key combination or by typing the following command if the device has USB debugging enabled:  
`adb reboot recovery`
* Select *Apply update* then *Apply from ADB* and install the package using the following command:  
`adb sideload BromiteSystemWebViewOverlay.zip`
* If the installer complains about signature verification, install anyway by selecting **Yes**.
* Reboot the device.
* [Download the latest Bromite SystemWebView release](https://www.bromite.org/system_web_view) and install it as you would a regular app.
* Lastly, navigate to *Settings > Developer options > WebView implementation* and select the appropriate package or run the following command:  
`adb shell cmd webviewupdate set-webview-implementation org.bromite.webview`

### Work Profile

Be aware that if you have a work profile enabled you also need to install the package from the work profile a second time (usually via de Work Files app), otherwise work apps that rely on the WebView component will refuse to work or crash altogether.

To ensure that the package is installed for both profiles install the package via ADB.

`adb install <package-name>.apk`

## Building

The following dependencies are required:

* `git`
* `xmlstarlet`
* `apktool`
* `aapt` (included)
* `zip`

To build the overlay and the flashable package, simply run the build script:
`./build.sh`

Alternatively, you can read a more in-depth guide [here](https://github.com/phhusson/treble_experimentations/wiki/How-to-create-an-overlay%3F).

## Credits

* [Pierre-Hugues Husson](https://github.com/phhusson) for the guide and toolkit



