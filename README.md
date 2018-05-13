# LSSLogger
A Lightweight and simple Swifty Logger.

[![Version](https://img.shields.io/cocoapods/v/LSSLogger.svg?style=flat)](http://cocoapods.org/pods/LSSLogger)
[![Carthage Compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/stv-yokudera/LSSLogger)
[![License](https://img.shields.io/cocoapods/l/LSSLogger.svg?style=flat)](http://cocoapods.org/pods/LSSLogger)
[![Platform](https://img.shields.io/cocoapods/p/LSSLogger.svg?style=flat)](http://cocoapods.org/pods/LSSLogger)

## Requirements
Swift Version 4.1 or more

## Installation

### Podfile

```ruby
target 'TargetName' do
use_frameworks!
pod "LSSLogger"
end
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
