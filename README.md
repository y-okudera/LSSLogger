# LSSLogger
A Lightweight and simple Swifty Logger.

[![Version](https://img.shields.io/cocoapods/v/LSSLogger.svg?style=flat)](http://cocoapods.org/pods/LSSLogger)
[![Carthage Compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/stv-yokudera/LSSLogger)
[![License](https://img.shields.io/cocoapods/l/LSSLogger.svg?style=flat)](http://cocoapods.org/pods/LSSLogger)
[![Platform](https://img.shields.io/cocoapods/p/LSSLogger.svg?style=flat)](http://cocoapods.org/pods/LSSLogger)

## Requirements
Swift Version 5.0 or more

## Installation

### CocoaPods

To integrate LSSLogger into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
platform :ios, '11.0'
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
github "y-okudera/LSSLogger" ~> 2.0
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
                 didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    // Set the log rotation count. (default: 10files)
    LSSLogger.configureLogRotationCount(count: 5)
    
    #if RELEASE
    
    // For release builds, logs are not output to the console.
    LSSLogger.outputToConsoleEnabled(isEnabled: false)
    
    // For release builds, logs are not output to files.
    LSSLogger.outputToFileEnabled(isEnabled: false)
    #endif
    
    return true
}
```

And, Active Compilation Conditions is as follows:
<img width="926" alt="2018-05-15 0 23 38" src="https://user-images.githubusercontent.com/25205138/40007027-c19b612e-57d6-11e8-897c-7d5af8431378.png">

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

本ライブラリについて、Qiitaにも記事を書きました。（Qiitaの記事は、全て日本語で書いています。）
https://qiita.com/okuderap/items/75f11230746eea59c695


## Author

YukiOkudera, appledev.yuoku@gmail.com

## License

LSSLogger is available under the MIT license. See the LICENSE file for more info.
