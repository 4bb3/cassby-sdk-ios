//
//  CoreDataStack.swift
//  CassbySDK
//
//  Created by Alexey on 11/01/2019.
//  Copyright © 2019 Alexey. All rights reserved.
//

import Foundation
import CoreData

internal class DB {
    
    var managedObjectContext: NSManagedObjectContext?
    
    init() {
        //This resource is the same name as your xcdatamodeld contained in your project
        guard let modelURL = Bundle(for: type(of: self).self).url(forResource: "CassbyModel", withExtension: "momd") else {
            fatalError("Error loading model from bundle")
        }
        // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
        guard let mom = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("Error initializing mom from: \(modelURL)")
        }
        
        let psc = NSPersistentStoreCoordinator(managedObjectModel: mom)
        
        managedObjectContext = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.mainQueueConcurrencyType)
        managedObjectContext?.persistentStoreCoordinator = psc
        
        guard let docURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last else {
            fatalError("Unable to resolve document directory")
        }
        let storeURL = docURL.appendingPathComponent("DataModel.sqlite")
        do {
            try psc.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: storeURL, options: nil)
            //The callback block is expected to complete the User Interface and therefore should be presented back on the main queue so that the user interface does not need to be concerned with which queue this call is coming from.
        } catch {
            fatalError("Error migrating store: \(error)")
        }
    }
    
    func saveContext() {
        
        guard let managedObjectContext = managedObjectContext else { return }
        
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch {
                let nserror = error as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                
            }
        }
    }

    func insert(check: Check) {
        
        guard let managedObjectContext = managedObjectContext else { return }
        
        guard let entityDescription = NSEntityDescription.entity(forEntityName: "CheckEntity", in: managedObjectContext) else { return }

        let managedObject = CheckEntity(entity: entityDescription, insertInto: managedObjectContext)

        managedObject.total = Int64(check.total)
        managedObject.dt_created = check.dt_created
        managedObject.is_synced = check.is_synced
        managedObject.uuid = check.uuid
        managedObject.id_branch = Int64(check.id_branch)

        if let payment = check.payment {
            guard let paymentEntity = NSEntityDescription.entity(forEntityName: "PaymentEntity", in: managedObjectContext) else { return }
            let paymentEntityObject = PaymentEntity(entity: paymentEntity, insertInto: managedObjectContext)

            paymentEntityObject.amount = Int64(payment.amount)
            paymentEntityObject.cash = Int64(payment.cash)
            paymentEntityObject.error_details = payment.error_details
            paymentEntityObject.id = Int64(payment.id)
            paymentEntityObject.is_synced = payment.is_synced
            paymentEntityObject.method = payment.method
            paymentEntityObject.pne_error_code = payment.pne_error_code
            paymentEntityObject.pne_id = payment.pne_id
            paymentEntityObject.status = payment.status
            paymentEntityObject.uuid = payment.uuid
            paymentEntityObject.uuid_check = payment.uuid_check
            managedObject.addToPayment(paymentEntityObject)
        }

        for item in check.items {
            guard let entityDescription = NSEntityDescription.entity(forEntityName: "CheckItemEntity", in: managedObjectContext) else { return }
            let printerCheckItemEntity = CheckItemEntity(entity: entityDescription, insertInto: managedObjectContext)

            printerCheckItemEntity.is_synced = item.is_synced
            printerCheckItemEntity.name = item.name
            printerCheckItemEntity.price = Int64(item.price)
            printerCheckItemEntity.qty = Int64(item.qty)
            printerCheckItemEntity.uuid = item.uuid
            printerCheckItemEntity.uuid_check = item.uuid_check
            managedObject.addToItems(printerCheckItemEntity)
        }

        saveContext()
    }
    
    func loadChecks() -> [Check] {
        let fetchRequest: NSFetchRequest<CheckEntity> = CheckEntity.fetchRequest()
        do {
            let results = try managedObjectContext?.fetch(fetchRequest)
            var array: [Check] = []
            for object in results ?? [] {
                let check = Check(managedObject: object)
                array.append(check)
            }
            return array
        } catch {
            print(error)
        }
        
        return []
    }

    func loadCheckItems() -> [CheckItem] {
        let fetchRequest: NSFetchRequest<CheckItemEntity> = CheckItemEntity.fetchRequest()
        do {
            let results = try managedObjectContext?.fetch(fetchRequest)
            var array: [CheckItem] = []
            for object in results ?? [] {
                let item = CheckItem(managedObject: object)
                array.append(item)
            }
            return array
        } catch {
            print(error)
        }
        
        return []
    }
    
    func loadPayments() -> [Payment] {
        let fetchRequest: NSFetchRequest<PaymentEntity> = PaymentEntity.fetchRequest()
        do {
            let results = try managedObjectContext?.fetch(fetchRequest)
            var array: [Payment] = []
            for object in results ?? [] {
                let payment = Payment(managedObject: object)
                array.append(payment)
            }
            return array
        } catch {
            print(error)
        }
        
        return []
    }
    
    func deleteCheck() {
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "CheckEntity")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        
        do {
            try managedObjectContext?.execute(deleteRequest)
            try managedObjectContext?.save()
        } catch {
            print ("There was an error")
        }
    }
    
    func deleteCheck_items() {
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "CheckItemEntity")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        
        do {
            try managedObjectContext?.execute(deleteRequest)
            try managedObjectContext?.save()
        } catch {
            print ("There was an error")
        }
    }
    
    func deletePayments() {
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "PaymentEntity")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        
        do {
            try managedObjectContext?.execute(deleteRequest)
            try managedObjectContext?.save()
        } catch {
            print ("There was an error")
        }
    }
}
