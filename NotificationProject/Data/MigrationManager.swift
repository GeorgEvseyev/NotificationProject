//
//  MigrationManager.swift
//  NotificationProject
//
//  Created by Георгий Евсеев on 8.11.25.
//

import Foundation

final class MigrationManager {
    private let storage: IStorageService
    private let interactor: NotificationsInteractor
    private let userDefaults: UserDefaults
    private let migratedFlagKey = "NotificationsMigrationDone_v1"

    init(storage: IStorageService,
         interactor: NotificationsInteractor,
         userDefaults: UserDefaults = .standard) {
        self.storage = storage
        self.interactor = interactor
        self.userDefaults = userDefaults
    }

    var isMigrated: Bool { userDefaults.bool(forKey: migratedFlagKey) }

    func migrateIfNeeded(completion: @escaping (Result<Void, Error>) -> Void) {
        guard !isMigrated else {
            completion(.success(()))
            return
        }

        let old = storage.loadNotifications() // [String: [MyNotification]]

        guard !old.isEmpty else {
            userDefaults.set(true, forKey: migratedFlagKey)
            completion(.success(()))
            return
        }

        DispatchQueue.global(qos: .userInitiated).async {
            do {
                let formatter = DateFormatter()
                formatter.dateFormat = "dd.MM.yyyy"
                for (dateString, items) in old {
                    let parsedDate = formatter.date(from: dateString)
                    for my in items {
                        if let existing = try self.interactor.fetchById(my.id) {
                            try? self.interactor.updateText(id: existing.id ?? my.id, text: my.text)
                            continue
                        }
                        let dateToUse = parsedDate ?? formatter.date(from: my.date) ?? Date()
                        let type = NotificationType(rawValue: Int16(my.type.rawValue)) ?? .expense
                        _ = try self.interactor.add(text: my.text, type: type, date: dateToUse)
                    }
                }
                self.userDefaults.set(true, forKey: self.migratedFlagKey)
                completion(.success(()))
            } catch {
                completion(.failure(error))
            }
        }
    }
}

