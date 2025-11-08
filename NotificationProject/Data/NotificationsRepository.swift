//
//  NotificationsRepository.swift
//  NotificationProject
//
//  Created by Георгий Евсеев on 8.11.25.
//

import Foundation
import CoreData

protocol NotificationsRepository {
    func add(text: String, type: NotificationType, date: Date) throws -> NotificationEntity
    func updateText(id: UUID, text: String) throws
    func toggleState(id: UUID) throws
    func delete(id: UUID) throws
    func fetchAll(on date: Date?) throws -> [NotificationEntity]
    func fetchByType(_ type: NotificationType) throws -> [NotificationEntity]
    func fetchById(_ id: UUID) throws -> NotificationEntity?
}

