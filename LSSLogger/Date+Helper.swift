//
//  Date+Helper.swift
//  LSSLogger
//
//  Created by YukiOkudera on 2018/05/13.
//  Copyright © 2018年 YukiOkudera. All rights reserved.
//

import Foundation

extension Date {
    
    /// convert Date type to String type
    func toStr(dateFormat: String) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = dateFormat
        
        return dateFormatter.string(from: self)
    }
}
