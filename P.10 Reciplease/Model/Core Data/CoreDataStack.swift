//
//  CoreDataTask.swift
//  P.10 Reciplease
//
//  Created by fardi Issihaka on 03/12/2021.
//

import Foundation
import CoreData

open class CoreDataStack {
    
    private let modelName: String
    
    public init(modelName: String) {
        self.modelName = modelName
    }
    
    public lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: modelName)
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                fatalError("error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    public lazy var context: NSManagedObjectContext = {
        return persistentContainer.viewContext
    }()
    
    public func saveContext() {
        guard context.hasChanges else { return }
        do {
            try context.save()
        } catch let error as NSError {
            print("error \(error), \(error.userInfo)")
        }
    }
}
