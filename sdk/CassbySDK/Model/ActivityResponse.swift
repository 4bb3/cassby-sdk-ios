//
//  ActivityResponse.swift
//  CassbySDK
//
//  Created by Alexey on 08/02/2019.
//  Copyright © 2019 Alexey. All rights reserved.
//

import Foundation

struct ActivityResponse: Codable {
    
    var check: [ResponseObj] = []
    var payment: [ResponseObj] = []
    var check_items: [ResponseObj] = []
    
}
