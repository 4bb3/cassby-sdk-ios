//
//  CheckItem.swift
//  CassbySDK
//
//  Created by Alexey on 11/01/2019.
//  Copyright © 2019 Alexey. All rights reserved.
//

import Foundation

internal class CheckItem: Codable {
    
    var uuid: String = UUID().uuidString
    var uuid_check: String = ""
    var qty: Double = 1
    var price: Int = 0
    var is_synced: Bool = false
    var name: String = ""

    internal convenience init(managedObject: CheckItemEntity) {
        self.init()
        self.uuid = managedObject.uuid ?? ""
        self.uuid_check = managedObject.uuid_check ?? ""
        self.qty = managedObject.qty
        self.price = Int(managedObject.price)
        self.is_synced = managedObject.is_synced
        self.name = managedObject.name ?? ""
    }
    
    internal convenience init(check: Check, name: String, price: Int, qty: Double) {
        self.init()
        self.uuid_check = check.uuid
        self.name = name
        self.qty = qty
        self.price = price
    }
    
    private enum CodingKeys: String, CodingKey {
        case uuid
        case uuid_check
        case qty
        case price
        case name
    }

}
