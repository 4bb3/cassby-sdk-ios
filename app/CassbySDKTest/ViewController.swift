//
//  ViewController.swift
//  CassbySDKTest
//
//  Created by Alexey on 14/01/2019.
//  Copyright © 2019 Alexey. All rights reserved.
//

import UIKit
import CassbySDK

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let manager = CheckManager.init()
        manager.addToCheck(name: "Товар", price: 100, qty: 1)
        manager.addPayment()
        manager.commit()
    }
}

