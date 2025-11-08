//
//  Untitled.swift
//  NotificationProject
//
//  Created by Георгий Евсеев on 8.11.25.
//

import Foundation

protocol NotificationsInteractor {
    func createEmpty(type: NotificationType, date: Date) throws -> NotificationEntity
    func add(text: String, type: NotificationType, date: Date) throws -> NotificationEntity
    func updateText(id: UUID, text: String) throws
    func toggle(id: UUID) throws
    func remove(id: UUID) throws
    func list(for date: Date?) throws -> [NotificationEntity]
    func fetchByType(_ type: NotificationType) throws -> [NotificationEntity]
    func fetchById(_ id: UUID) throws -> NotificationEntity?
}

final class DefaultNotificationsInteractor: NotificationsInteractor {
    private let repo: NotificationsRepository

    init(repo: NotificationsRepository = CoreDataNotificationsRepository()) {
        self.repo = repo
    }

    func createEmpty(type: NotificationType, date: Date) throws -> NotificationEntity {
        return try repo.add(text: "", type: type, date: date) // или repo.createEmpty если есть
    }

    func add(text: String, type: NotificationType, date: Date) throws -> NotificationEntity {
        return try repo.add(text: text, type: type, date: date)
    }

    // реализуй остальные методы, например:
    func updateText(id: UUID, text: String) throws { try repo.updateText(id: id, text: text) }
    func toggle(id: UUID) throws { try repo.toggleState(id: id) }
    func remove(id: UUID) throws { try repo.delete(id: id) }
    func list(for date: Date?) throws -> [NotificationEntity] { try repo.fetchAll(on: date) }
    func fetchByType(_ type: NotificationType) throws -> [NotificationEntity] { try repo.fetchByType(type) }
    func fetchById(_ id: UUID) throws -> NotificationEntity? { try repo.fetchById(id) }
}

