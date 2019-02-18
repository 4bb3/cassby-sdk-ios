//
//  Sync.swift
//  CassbySDK
//
//  Created by Alexey on 08/02/2019.
//  Copyright © 2019 Alexey. All rights reserved.
//

import Foundation

class Sync {
    
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
            let request = NSMutableURLRequest(url: URL(string: "https://cassby.com/api/v2/app/activity?token=" + token)!)
            request.httpMethod = "POST"
            let session = URLSession.shared
            
            let jsonEncoder = JSONEncoder()
            
            do {
                let jsonData = try jsonEncoder.encode(data)
                request.httpBody = jsonData
                let task = session.dataTask(with: request as URLRequest) { data, response, error in
                    guard let data = data else { return }
                    do {
//                        let gitData = try JSONDecoder().decode(ResponseRoot.self, from: data)
//                        print("response data:", gitData)
                        
                        guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary else {
                            return
                        }
                        print(json)
                        
                    } catch let err {
                        print("Err", err)
                    }
                }
                
                task.resume()
            } catch let err  {
                print("Error encoding data:", err)
            }
        }
    }
}
