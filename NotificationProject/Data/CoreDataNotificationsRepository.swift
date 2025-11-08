//
//  CoreDataNotificationsRepository.swift
//  NotificationProject
//
//  Created by Георгий Евсеев on 8.11.25.
//

import Foundation
import CoreData

final class CoreDataNotificationsRepository: NotificationsRepository {
    private let coreData: CoreDataManager

    init(coreData: CoreDataManager = CoreDataManager.shared) {
        self.coreData = coreData
    }

    func add(text: String, type: NotificationType, date: Date) throws -> NotificationEntity {
        let context = coreData.context
        guard let entityDesc = NSEntityDescription.entity(forEntityName: "NotificationEntity", in: context) else {
            throw NSError(domain: "CoreData", code: 1, userInfo: [NSLocalizedDescriptionKey: "Entity NotificationEntity not found in model"])
        }

        let note = NotificationEntity(entity: entityDesc, insertInto: context)
        note.id = UUID()
        note.text = text
        note.state = false
        note.date = date
        note.type = type.rawValue

        do {
            try coreData.saveContext()
        } catch {
            print("CoreDataNotificationsRepository.add save error:", error)
            throw error
        }
        return note
    }

    func updateText(id: UUID, text: String) throws {
        guard let note = try fetchById(id) else { return }
        note.text = text
        try coreData.saveContext()
    }

    func toggleState(id: UUID) throws {
        guard let note = try fetchById(id) else { return }
        note.state.toggle()
        try coreData.saveContext()
    }

    func delete(id: UUID) throws {
        guard let note = try fetchById(id) else { return }
        coreData.context.delete(note)
        try coreData.saveContext()
    }

    func fetchAll(on date: Date?) throws -> [NotificationEntity] {
        let req: NSFetchRequest<NotificationEntity> = NotificationEntity.fetchRequest()
        if let date = date {
            let cal = Calendar.current
            let start = cal.startOfDay(for: date)
            guard let end = cal.date(byAdding: .day, value: 1, to: start) else {
                return try coreData.context.fetch(req)
            }
            req.predicate = NSPredicate(format: "date >= %@ AND date < %@", start as NSDate, end as NSDate)
        }
        req.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        return try coreData.context.fetch(req)
    }

    func fetchByType(_ type: NotificationType) throws -> [NotificationEntity] {
        let req: NSFetchRequest<NotificationEntity> = NotificationEntity.fetchRequest()
        req.predicate = NSPredicate(format: "type == %d", type.rawValue)
        req.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        return try coreData.context.fetch(req)
    }

    func fetchById(_ id: UUID) throws -> NotificationEntity? {
        let req: NSFetchRequest<NotificationEntity> = NotificationEntity.fetchRequest()
        req.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        req.fetchLimit = 1
        return try coreData.context.fetch(req).first
    }
}




