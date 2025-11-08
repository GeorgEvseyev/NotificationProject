//
//  CoreDataManager.swift
//  NotificationProject
//
//  Created by Георгий Евсеев on 8.11.25.
//

import Foundation
import CoreData

final class CoreDataManager {
    static let shared = CoreDataManager()
    private init() {}

    private let modelName = "NotificationModel" 

    lazy var container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: modelName)
        container.loadPersistentStores { storeDescription, error in
            if let error = error {
                print("Core Data load error:", error)
            } else {
                print("Loaded store:", storeDescription)
            }
            // Диагностика: перечислим сущности
            let model = container.managedObjectModel
            let entityNames = model.entities.compactMap { $0.name }
            print("Core Data model entities:", entityNames)
        }
        return container
    }()

    var context: NSManagedObjectContext { container.viewContext }

    func saveContext() throws {
        guard context.hasChanges else { return }
        try context.save()
    }
}


