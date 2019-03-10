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
        let check = CheckManager(id_branch: 1)
        check.addToCheck(name: "Пикачу", price: 1900, qty: 1)
        check.commit()
        
        let check2 = CheckManager(id_branch: 2)
        check2.addToCheck(name: "Чупачупс", price: 1900, qty: 1)
        check2.commit()
    }
}

    
