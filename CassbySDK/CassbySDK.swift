//
//  CassbySDK.swift
//  CassbySDK
//
//  Created by Alexey on 08/02/2019.
//  Copyright © 2019 Alexey. All rights reserved.
//

import Foundation

public class CassbySDK {
    
    public static let shared = CassbySDK()
    
    var token: String = ""
    var timer: Repeater?
    
    public func launch(token: String) {
        self.token = token
        self.timer = Repeater.every(.seconds(5), { (repeater) in
            let sync = Sync()
            sync.syncData()
        })
    }
}
