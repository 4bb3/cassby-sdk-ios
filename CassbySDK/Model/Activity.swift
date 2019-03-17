//
//  Activity.swift
//  CassbySDK
//
//  Created by Alexey on 08/02/2019.
//  Copyright © 2019 Alexey. All rights reserved.
//

import Foundation

struct Activity: Codable {
    
    var check: [Check] = []
    var check_item: [CheckItem] = []
    var payment: [Payment] = []
    
}
