//
//  ViewController.swift
//  CassbySDKTest
//
//  Created by Alexey on 14/01/2019.
//  Copyright © 2019 Alexey. All rights reserved.
//

import UIKit
import CassbySDK
import SnapKit

class ViewController: UIViewController {

    lazy var name: UITextField = {
        let view = UITextField()
        view.keyboardType = .default
        view.borderStyle = .bezel
        view.placeholder = "Название"
        return view
    }()
    
    lazy var qty: UITextField = {
        let view = UITextField()
        view.keyboardType = .numberPad
        view.borderStyle = .bezel
        view.placeholder = "Количество"
        return view
    }()
    
    lazy var price: UITextField = {
        let view = UITextField()
        view.keyboardType = .numberPad
        view.borderStyle = .bezel
        view.placeholder = "Цена в копейках"
        return view
    }()
    
    lazy var branch: UITextField = {
        let view = UITextField()
        view.keyboardType = .numberPad
        view.borderStyle = .bezel
        view.placeholder = "Филиал"
        return view
    }()
    
    
    lazy var button: UIButton = {
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(buttonHandler), for: .touchUpInside)
        button.setTitle("GO!", for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    func setupViews() {
        view.addSubview(name)
        view.addSubview(qty)
        view.addSubview(price)
        view.addSubview(branch)
        view.addSubview(button)
        
        name.snp.makeConstraints({ make in
            make.left.equalTo(self.view.snp.left).offset(20)
            make.right.equalTo(self.view.snp.right).offset(-20)
            make.top.equalTo(self.view.snp.top).offset(50)
            make.height.equalTo(40)
        })
        
        qty.snp.makeConstraints({ make in
            make.left.equalTo(self.view.snp.left).offset(20)
            make.right.equalTo(self.view.snp.right).offset(-20)
            make.top.equalTo(self.name.snp.bottom).offset(20)
            make.height.equalTo(40)
            
        })
        
        price.snp.makeConstraints({ make in
            make.left.equalTo(self.view.snp.left).offset(20)
            make.right.equalTo(self.view.snp.right).offset(-20)
            make.top.equalTo(self.qty.snp.bottom).offset(20)
            make.height.equalTo(40)
            
        })
        
        branch.snp.makeConstraints({ make in
            make.left.equalTo(self.view.snp.left).offset(20)
            make.right.equalTo(self.view.snp.right).offset(-20)
            make.top.equalTo(self.price.snp.bottom).offset(20)
            make.height.equalTo(40)
        })
        
        button.snp.makeConstraints({ make in
            make.centerX.equalTo(self.view.snp.centerX)
            make.top.equalTo(self.branch.snp.bottom).offset(20)
            make.height.equalTo(40)
            
        })
    }
    
    @objc func buttonHandler() {
        guard let name = name.text, let qty = qty.text, let price = price.text, let id_branch = branch.text else {
            return
        }
        
        let check = CheckManager(id_branch: Int(id_branch) ?? 0)
        check.addToCheck(name: name, price: Int(price) ?? 0, qty: Double(qty) ?? 0)
        check.commit()
        
        self.name.text = ""
        self.qty.text = ""
        self.price.text = ""
        self.branch.text = ""
    }
}

    
