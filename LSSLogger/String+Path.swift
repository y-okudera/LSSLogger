//
//  String+Path.swift
//  LSSLogger
//
//  Created by YukiOkudera on 2018/05/13.
//  Copyright © 2018年 YukiOkudera. All rights reserved.
//

import Foundation

extension String {
    
    private var ns: NSString {
        return (self as NSString)
    }
    
    func appendingPathComponent(_ str: String) -> String {
        return ns.appendingPathComponent(str)
    }
}
