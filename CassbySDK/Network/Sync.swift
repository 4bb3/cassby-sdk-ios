//
//  Sync.swift
//  CassbySDK
//
//  Created by Alexey on 08/02/2019.
//  Copyright © 2019 Alexey. All rights reserved.
//

import Foundation

class Sync {
    
    var url = "http://46.101.175.222"
    
    func prepareActivity() -> Root {
        let db = DB()
    
        let checks = db.loadChecks()
        let payments = db.loadPayments()
        let checkItems = db.loadCheckItems()
    
        let activity = Activity.init(check: checks, check_item: checkItems, payment: payments)
        return Root.init(activity: activity)
    }
    
    func syncData() {
        let data = prepareActivity()
        let token = CassbySDK.shared.token
        
        if data.activity.check.isEmpty == false && data.activity.check_item.isEmpty == false && data.activity.payment.isEmpty == false {
            var request = URLRequest(url: URL(string: self.url + "/activity?token=" + token)!)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-type")
            
            do {
                let jsonData = try JSONEncoder().encode(data)
                request.httpBody = jsonData
                let task = URLSession.shared.dataTask(with: request as URLRequest) { data, response, error in
                    guard data != nil else { return }
                    
                    if let httpResponse = response as? HTTPURLResponse {
                        if httpResponse.statusCode == 200 {
                            let db = DB()
                            db.deleteCheck()
                            db.deleteCheck_items()
                            db.deletePayments()
                        }
                    }
                    
                }
                
                task.resume()
            } catch _  {
                
            }
        }
    }
}
