//
//  CheckManager.swift
//  CassbySDK
//
//  Created by Alexey on 14/01/2019.
//  Copyright © 2019 Alexey. All rights reserved.
//

import Foundation

open class CheckManager {
    
    private var check: Check
    private var database: DB
    private var pneId: String?
    
    public init(id_branch: Int, pneId: String?) {
        self.check = Check(id_branch: id_branch)
        self.database = DB()
        self.pneId = pneId
    }
    
    public func addToCheck(name: String, price: Int, qty: Double) {
        self.check.addCheckItem(name: name, price: price, qty: qty)
    }

    public func commit() {
        self.check.addPayment(payment: Payment.init(check: self.check, pneId: pneId))
        database.insert(check: self.check)
    }
    
}
