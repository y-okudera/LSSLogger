//
//  String+Directory.swift
//  LSSLogger
//
//  Created by YukiOkudera on 2018/05/13.
//  Copyright © 2018年 YukiOkudera. All rights reserved.
//

import Foundation

extension String {
    
    /// ~/Documents
    static func documentsDirectory() -> String {
        return NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
    }
}
