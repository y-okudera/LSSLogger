# LSSLogger
A Lightweight and simple Swifty Logger.

[![Version](https://img.shields.io/cocoapods/v/LSSLogger.svg?style=flat)](http://cocoapods.org/pods/LSSLogger)
[![Carthage Compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/stv-yokudera/LSSLogger)
[![License](https://img.shields.io/cocoapods/l/LSSLogger.svg?style=flat)](http://cocoapods.org/pods/LSSLogger)
[![Platform](https://img.shields.io/cocoapods/p/LSSLogger.svg?style=flat)](http://cocoapods.org/pods/LSSLogger)

## Requirements
Swift Version 4.1 or more

## Installation

### CocoaPods

To integrate LSSLogger into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
platform :ios, '9.0'
use_frameworks!

target '<TargetName>' do
    pod "LSSLogger"
end
```

Then, run the following command:

```bash
$ pod install
```

### Carthage

To integrate LSSLogger into your Xcode project using Carthage, specify it in your `Cartfile`:

```ogdl
github "stv-yokudera/LSSLogger" ~> 1.0
```

Run `carthage update` to build the framework and drag the built `LSSLogger.framework` into your Xcode project.

## Setup

By default, whether to output logs is as follows:

|LogLevel|DEBUG|INFO|WARNING|ERROR|FATAL|
|:----:|:----:|:----:|:----:|:----:|:----:|
|Output to console|◯|◯|◯|◯|◯|
|Output to log file|×|◯|◯|◯|◯|

When you don't want to output the log in the release build, In AppDelegate, set as follows:

```swift:AppDelegate.swift
func application(_ application: UIApplication,
                 didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.

    #if RELEASE
    // For release builds, logs aren't output to the console.
    LSSLogger.outputToConsoleEnabled(isEnabled: false)

    // For release builds, logs aren't output to the files.
    LSSLogger.outputToFileEnabled(isEnabled: false)
    #endif

    return true
}
```

## Usage

```swift
import LSSLogger

func debugLogDemo() {
    // Output to the console.
    LSSLogger.console.debug()
    LSSLogger.console.debug(message: "foo")
    LSSLogger.console.info()

    // Output to the file.
    LSSLogger.file.info(message: "bar")
    LSSLogger.file.warning()
    LSSLogger.file.error()
    LSSLogger.file.fatal()

    // Output to the console and file.
    LSSLogger.consoleAndFile.info(message: "foobar")
    LSSLogger.consoleAndFile.warning()
    LSSLogger.consoleAndFile.error()
    LSSLogger.consoleAndFile.fatal()
}
```

## Author

YukiOkudera, appledev.yuoku@gmail.com

## License

LSSLogger is available under the MIT license. See the LICENSE file for more info.
