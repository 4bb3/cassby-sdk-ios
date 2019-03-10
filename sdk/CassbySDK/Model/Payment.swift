//
//  Payment.swift
//  CassbySDK
//
//  Created by Alexey on 11/01/2019.
//  Copyright © 2019 Alexey. All rights reserved.
//

import Foundation

class Payment: Codable {
    
    internal var uuid: String = UUID().uuidString
    internal var uuid_check: String = ""
    internal var amount: Int = 0
    internal var cash: Int = 0
    internal var error_details: String = ""
    internal var id: Int = 0
    internal var is_synced: Bool = false
    internal var method: String = "card"
    internal var status: String = "success"
    internal var pne_id: String = ""
    internal var pne_error_code: String = ""
    
    internal init(check: Check) {
        self.uuid_check = check.uuid
        
        var total = 0
        
        for item in check.items {
            total = total + Int(item.qty * Double(item.price))
        }
        
        self.amount = total
    }
    
    internal init(managedObject: PaymentEntity) {
        self.uuid = managedObject.uuid ?? ""
        self.uuid_check = managedObject.uuid_check ?? ""
        self.amount = Int(managedObject.amount) 
        self.cash = Int(managedObject.cash) 
        self.error_details = managedObject.error_details ?? ""
        self.id = Int(managedObject.id) 
        self.is_synced = managedObject.is_synced 
        self.method = managedObject.method ?? ""
        self.status = managedObject.status ?? ""
        self.pne_id = managedObject.pne_id ?? ""
        self.pne_error_code = managedObject.pne_error_code ?? ""
    }
    
    private enum CodingKeys: String, CodingKey {
        case uuid
        case uuid_check
        case amount
        case cash
        case error_details
        case id
        case is_synced
        case method
        case status
        case pne_id
        case pne_error_code
    }
}
