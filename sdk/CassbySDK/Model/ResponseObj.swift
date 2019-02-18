//
//  ResponseObj.swift
//  CassbySDK
//
//  Created by Alexey on 08/02/2019.
//  Copyright © 2019 Alexey. All rights reserved.
//

import Foundation

struct ResponseObj: Codable {
    
    var uuid: String
    var id: Int
    var status: String
    var error_details: String
    
}
