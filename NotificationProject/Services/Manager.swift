//
//  Manager.swift
//  NotificationProject
//
//  Created by Георгий Евсеев on 5.12.23.
//

import Foundation

protocol ManagerDelegate: AnyObject {
    func updateData()
}

protocol IManager {
    func removeNotification(id: UUID)
    func addNotification(notification: MyNotification)
    func toggleNotificationState(id: UUID)
    func updateNotificationText(id: UUID, newText: String)
    func getNumber() -> Int
    func setDate(date: String)
    func getDate() -> String
    func loadNotifications()
    func hasNotifications(for date: String) -> Bool
    func moveNotification(from sourceIndex: Int, to destinationIndex: Int, for date: String)
}

final class Manager: IManager {
    static let shared = Manager()

    private let storageService: IStorageService
    private let interactor: NotificationsInteractor

    private(set) var selectedDate: String = ""
    private(set) var notifications = [String: [MyNotification]]()

    // MARK: - Init

    init(storageService: IStorageService = StorageService(),
         interactor: NotificationsInteractor = DefaultNotificationsInteractor(repo: CoreDataNotificationsRepository())) {
        self.storageService = storageService
        self.interactor = interactor

        do {
            try loadFromCoreData()
        } catch {
            notifications = storageService.loadNotifications()
            print("Manager: fallback to storageService due to Core Data error: \(error)")
        }
    }

    // MARK: - DateFormatter

    private static let dateFormatter: DateFormatter = {
        let f = DateFormatter()
        f.dateFormat = "dd.MM.yyyy"
        f.locale = Locale.current
        return f
    }()

    // MARK: - Mapping

    private func map(_ entity: NotificationEntity) -> MyNotification {
        let id = entity.id ?? UUID()
        let date = entity.date ?? Date()
        let dateString = Manager.dateFormatter.string(from: date)
        let type = NotificationType(rawValue: entity.type) ?? .expense

        return MyNotification(
            id: id,
            text: entity.text ?? "",
            date: dateString,
            number: 0,
            state: entity.state,
            type: type
        )
    }

    private func mapToRepoArgs(_ my: MyNotification) -> (text: String, type: NotificationType, date: Date) {
        let date = Manager.dateFormatter.date(from: my.date) ?? Date()
        let repoType = my.type
        return (text: my.text, type: repoType, date: date)
    }


    // MARK: - Load / Refresh

    private func loadFromCoreData() throws {
        let date: Date? = {
            guard !selectedDate.isEmpty else { return nil }
            return Manager.dateFormatter.date(from: selectedDate)
        }()

        let entities = try interactor.list(for: date)
        var dict = [String: [MyNotification]]()

        for e in entities {
            let key = Manager.dateFormatter.string(from: e.date ?? Date())
            dict[key, default: []].append(map(e))
        }

        // Сортируем и проставляем number
        for (k, var arr) in dict {
            arr.sort {
                if $0.state == $1.state {
                    return $0.text.localizedCaseInsensitiveCompare($1.text) == .orderedAscending
                }
                return !$0.state && $1.state
            }
            for i in 0..<arr.count {
                arr[i].number = i
            }
            dict[k] = arr
        }

        notifications = dict
        storageService.saveNotifications(notifications)
    }

    private func refreshDateNotifications(dateString: String) throws {
        let date = Manager.dateFormatter.date(from: dateString)
        let entities = try interactor.list(for: date)
        var arr = entities.map { map($0) }

        arr.sort {
            if $0.state == $1.state {
                return $0.text.localizedCaseInsensitiveCompare($1.text) == .orderedAscending
            }
            return !$0.state && $1.state
        }

        for i in 0..<arr.count {
            arr[i].number = i
        }

        notifications[dateString] = arr
        storageService.saveNotifications(notifications)
    }

    // MARK: - CRUD

    func removeNotification(id: UUID) {
        do {
            try interactor.remove(id: id)
        } catch {
            print("Manager.removeNotification CoreData error: \(error)")
        }

        for (date, items) in notifications {
            if let index = items.firstIndex(where: { $0.id == id }) {
                notifications[date]?.remove(at: index)
                // пересчитаем number
                reindex(date: date)
                storageService.saveNotifications(notifications)
                return
            }
        }
    }

    func addNotification(notification: MyNotification) {
        let args = mapToRepoArgs(notification)
        do {
            _ = try interactor.add(text: args.text, type: args.type, date: args.date)
            try refreshDateNotifications(dateString: selectedDate)
        } catch {
            print("Manager.addNotification CoreData error: \(error)")
            notifications[selectedDate, default: []].insert(notification, at: 0)
            reindex(date: selectedDate)
            storageService.saveNotifications(notifications)
        }
    }


    func toggleNotificationState(id: UUID) {
        do {
            try interactor.toggle(id: id)
            // Обновим локальный кэш: лучше перезагрузить дату, где находится элемент
            for (date, _) in notifications {
                if notifications[date]?.contains(where: { $0.id == id }) == true {
                    try? refreshDateNotifications(dateString: date)
                    return
                }
            }
        } catch {
            print("Manager.toggleNotificationState CoreData error: \(error)")
            // fallback локально
            for (date, items) in notifications {
                if let index = items.firstIndex(where: { $0.id == id }) {
                    notifications[date]?[index].state.toggle()
                    notifications[date]?.sort {
                        if $0.state == $1.state { return $0.text.localizedCaseInsensitiveCompare($1.text) == .orderedAscending }
                        return !$0.state && $1.state
                    }
                    reindex(date: date)
                    storageService.saveNotifications(notifications)
                    return
                }
            }
        }
    }

    func updateNotificationText(id: UUID, newText: String) {
        do {
            try interactor.updateText(id: id, text: newText)
            for (date, _) in notifications {
                if notifications[date]?.contains(where: { $0.id == id }) == true {
                    try? refreshDateNotifications(dateString: date)
                    return
                }
            }
        } catch {
            print("Manager.updateNotificationText CoreData error: \(error)")
            for (date, items) in notifications {
                if let index = items.firstIndex(where: { $0.id == id }) {
                    notifications[date]?[index].text = newText
                    storageService.saveNotifications(notifications)
                    return
                }
            }
        }
    }

    // MARK: - Date

    func getNumber() -> Int {
        notifications[selectedDate]?.count ?? 0
    }

    func setDate(date: String) {
        selectedDate = date
        do {
            try refreshDateNotifications(dateString: date)
        } catch {
            print("Manager.setDate refresh error: \(error)")
        }
    }

    func getDate() -> String {
        selectedDate
    }

    func loadNotifications() {
        do {
            try loadFromCoreData()
        } catch {
            notifications = storageService.loadNotifications()
            print("Manager.loadNotifications fallback storageService: \(error)")
        }
    }

    // MARK: - Utilities

    func hasNotifications(for date: String) -> Bool {
        return notifications[date]?.isEmpty == false
    }

    func moveNotification(from sourceIndex: Int, to destinationIndex: Int, for date: String) {
        guard var items = notifications[date],
              sourceIndex < items.count,
              destinationIndex <= items.count else { return }

        let item = items.remove(at: sourceIndex)
        items.insert(item, at: destinationIndex)
        notifications[date] = items
        reindex(date: date)
        storageService.saveNotifications(notifications)

        // Для сохранения порядка в Core Data добавь атрибут order: Int16 и сохраняй его через interactor/repo.
    }

    private func reindex(date: String) {
        guard var arr = notifications[date] else { return }
        for i in 0..<arr.count {
            arr[i].number = i
        }
        notifications[date] = arr
    }
}

