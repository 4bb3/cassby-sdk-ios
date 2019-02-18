//
//  CheckManager.swift
//  CassbySDK
//
//  Created by Alexey on 14/01/2019.
//  Copyright © 2019 Alexey. All rights reserved.
//

import Foundation

public class CheckManager {
    
    private var check: Check
    private var database: DB
    
    public init() {
        self.check = Check.init()
        self.database = DB()
    }
    
    public func addToCheck(name: String, price: Int, qty: Int) {
        self.check.addCheckItem(name: name, price: price, qty: qty)
    }
    
    public func addPayment() {
        self.check.addPayment(payment: Payment.init(check: self.check))
    }
    
    public func commit() {
        database.insert(check: self.check)
    }
    
}
