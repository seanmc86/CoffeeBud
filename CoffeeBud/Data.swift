//
//  Data.swift
//  CoffeeBud
//
//  Created by Sean McCalgan on 2018/04/12.
//  Copyright © 2018 Sean McCalgan. All rights reserved.
//

import Foundation
import CoreData

class Data {
    
    func initDataContainer() {
    
        let container = NSPersistentContainer(name: "DataModel")
        container.loadPersistentStores(completionHandler: { (description, error) in
            if let error = error {
                fatalError("Unable to load persistent stores: \(error)")
            }
        })
        
        guard let modelURL = Bundle.main.url(forResource: "DataModel", withExtension: "momd") else {
            fatalError("failed to find data model")
        }
        guard let mom = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("Failed to create model from file: \(modelURL)")
        }
        
        let psc = NSPersistentStoreCoordinator(managedObjectModel: mom)
        
        let dirURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last
        let fileURL = URL(string: "DataModel.sql", relativeTo: dirURL)
        do {
            try psc.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: fileURL, options: nil)
        } catch {
            fatalError("Error configuring persistent store: \(error)")
        }
        
        let moc = NSManagedObjectContext(concurrencyType:.mainQueueConcurrencyType)
        moc.persistentStoreCoordinator = psc
    
    }
    
}
