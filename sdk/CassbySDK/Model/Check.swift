//
//  Check.swift
//  CassbySDK
//
//  Created by Alexey on 11/01/2019.
//  Copyright © 2019 Alexey. All rights reserved.
//

import Foundation

internal class Check: Codable {
    
    internal var total: Int = 0
    internal var dt_created: String = Date().toString()
    internal var is_synced: Bool = false
    internal var uuid: String = UUID().uuidString
    internal var items: [CheckItem] = []
    internal var payment: Payment? = nil
    
    init() {
        
    }
    
    internal init(managedObject: CheckEntity) {
        self.total = Int(managedObject.total)
        self.dt_created = managedObject.dt_created ?? ""
        self.uuid = managedObject.uuid ?? ""
        self.is_synced = managedObject.is_synced
    }
    
    internal func addCheckItem(name: String, price: Int, qty: Int) {
        items.append(CheckItem(check: self, name: name, price: price, qty: qty))
    }
    
    internal func addPayment(payment: Payment) {
        self.payment = payment
    }
    
    private enum CodingKeys: String, CodingKey {
        case total
        case dt_created
        case uuid
    }
}
