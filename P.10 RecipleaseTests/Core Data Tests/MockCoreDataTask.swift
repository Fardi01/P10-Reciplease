//
//  MockCoreDataTask.swift
//  P.10 RecipleaseTests
//
//  Created by fardi Issihaka on 03/12/2021.
//

import Foundation
import CoreData
import P_10_Reciplease


final class MockCoreDataStack: CoreDataStack {
    
    convenience init() {
        self.init(modelName: "P_10_Reciplease")
    }
    
    override init(modelName: String) {
        super.init(modelName: modelName)
        let persistentStoreDescription = NSPersistentStoreDescription()
        persistentStoreDescription.type = NSInMemoryStoreType
        let container = NSPersistentContainer(name: modelName)
        container.persistentStoreDescriptions = [persistentStoreDescription]
        container.loadPersistentStores { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        self.persistentContainer = container
    }
}
