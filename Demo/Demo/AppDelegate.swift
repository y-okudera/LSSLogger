//
//  AppDelegate.swift
//  Demo
//
//  Created by YukiOkudera on 2018/05/13.
//  Copyright © 2018年 YukiOkudera. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
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
}
