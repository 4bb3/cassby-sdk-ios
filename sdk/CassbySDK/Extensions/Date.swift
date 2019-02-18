//
//  Date.swift
//  CassbySDK
//
//  Created by Alexey on 11/01/2019.
//  Copyright © 2019 Alexey. All rights reserved.
//

import Foundation

extension Date {
    
    func toString(format: String = "yyyy-MM-dd HH:mm:ss") -> String {
        // format - 2017-06-25 15:04:05
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
}
