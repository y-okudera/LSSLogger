//
//  ViewController.swift
//  Demo
//
//  Created by YukiOkudera on 2018/05/13.
//  Copyright © 2018年 YukiOkudera. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        debugLogDemo()
        infoLogDemo()
        warningLogDemo()
        errorLogDemo()
        fatalLogDemo()
    }

    private func debugLogDemo() {

        // Output the debug log to the console.

        // yyyy/MM/dd HH:mm:ss:SSS 🐥[DEBUG] debugLogDemo() @ViewController.swift(Line 28)🐥
        LSSLogger.console.debug()

        // yyyy/MM/dd HH:mm:ss:SSS 🐥[DEBUG] debugLogDemo() @ViewController.swift(Line 31) > foo🐥
        LSSLogger.console.debug(message: "foo")
    }

    private func infoLogDemo() {

        // Output the info log to the console.

        // yyyy/MM/dd HH:mm:ss:SSS 🔔[INFO] infoLogDemo() @ViewController.swift(Line 39)🔔
        LSSLogger.console.info()

        // Output the info log to the file.

        // yyyy/MM/dd HH:mm:ss:SSS [INFO] infoLogDemo() @ViewController.swift(Line 44) > bar
        LSSLogger.file.info(message: "bar")

        // Output the info log to the console and file.

        // Console log: yyyy/MM/dd HH:mm:ss:SSS 🔔[INFO] infoLogDemo() @ViewController.swift(Line 50)🔔
        // File log: yyyy/MM/dd HH:mm:ss:SSS [INFO] infoLogDemo() @ViewController.swift(Line 50)
        LSSLogger.consoleAndFile.info()
    }

    private func warningLogDemo() {
        // yyyy/MM/dd HH:mm:ss:SSS ⚠️[WARNING] warningLogDemo() @ViewController.swift(Line 55)⚠️
        LSSLogger.console.warning()
    }

    private func errorLogDemo() {
        // Console log: yyyy/MM/dd HH:mm:ss:SSS ‼️[ERROR] errorLogDemo() @ViewController.swift(Line 61)‼️
        // File log: yyyy/MM/dd HH:mm:ss:SSS [ERROR] errorLogDemo() @ViewController.swift(Line 61)
        LSSLogger.consoleAndFile.error()
    }

    private func fatalLogDemo() {
        // Console log: yyyy/MM/dd HH:mm:ss:SSS 💔[FATAL] fatalLogDemo() @ViewController.swift(Line 67)💔
        // File log: yyyy/MM/dd HH:mm:ss:SSS [FATAL] fatalLogDemo() @ViewController.swift(Line 67)
        LSSLogger.consoleAndFile.fatal()
    }
}

