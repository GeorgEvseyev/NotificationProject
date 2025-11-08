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
    
    // Новый метод
    func hasNotifications(for date: String) -> Bool
    func moveNotification(from sourceIndex: Int, to destinationIndex: Int, for date: String)
}

final class Manager: IManager {
    static let shared = Manager()
    private let storageService: IStorageService

    private(set) var selectedDate: String = ""
    private(set) var notifications = [String: [MyNotification]]()

    init(storageService: IStorageService = StorageService()) {
        self.storageService = storageService
        self.notifications = storageService.loadNotifications()
    }

    // MARK: - CRUD

    func removeNotification(id: UUID) {
        for (date, items) in notifications {
            if let index = items.firstIndex(where: { $0.id == id }) {
                notifications[date]?.remove(at: index)
                storageService.saveNotifications(notifications)
                return
            }
        }
    }

    func addNotification(notification: MyNotification) {
        notifications[selectedDate, default: []].insert(notification, at: 0)
        storageService.saveNotifications(notifications)
    }

    func toggleNotificationState(id: UUID) {
        for (date, items) in notifications {
            if let index = items.firstIndex(where: { $0.id == id }) {
                notifications[date]?[index].state.toggle()
                notifications[date]?.sort {
                    if $0.state == $1.state {
                        return $0.text.localizedCaseInsensitiveCompare($1.text) == .orderedAscending
                    }
                    return !$0.state && $1.state
                }
                storageService.saveNotifications(notifications)
                return
            }
        }
    }

    func updateNotificationText(id: UUID, newText: String) {
        for (date, items) in notifications {
            if let index = items.firstIndex(where: { $0.id == id }) {
                notifications[date]?[index].text = newText
                storageService.saveNotifications(notifications)
                return
            }
        }
    }

    // MARK: - Date

    func getNumber() -> Int {
        notifications[selectedDate]?.count ?? 0
    }

    func setDate(date: String) {
        selectedDate = date
    }

    func getDate() -> String {
        selectedDate
    }

    func loadNotifications() {
        notifications = storageService.loadNotifications()
    }

    // MARK: - Новый метод
    func hasNotifications(for date: String) -> Bool {
        return notifications[date]?.isEmpty == false
    }

    // MARK: - Перемещение
    func moveNotification(from sourceIndex: Int, to destinationIndex: Int, for date: String) {
        guard var items = notifications[date],
              sourceIndex < items.count,
              destinationIndex <= items.count else { return }

        let item = items.remove(at: sourceIndex)
        items.insert(item, at: destinationIndex)
        notifications[date] = items
        storageService.saveNotifications(notifications)
    }
}


////
////  Manager.swift
////  NotificationProject
////
////  Created by Георгий Евсеев on 5.12.23.
////
//
//import Foundation
//import UIKit
//
//protocol ManagerDelegate: AnyObject {
//    func updateData()
//}
//
//protocol IManager {
//    func removeNotification(notification: MyNotification)
//    func addNotification(notification: MyNotification)
//    func toggleNotificationState(notification: MyNotification)
//    func setNumber()
//    func getNumber() -> Int
//    func setDate(date: String)
//    func getDate() -> String
//}
//
//final class Manager: IManager {
//    static let shared = Manager()
//    weak var delegate: ManagerDelegate?
//    private var storageService: IStorageService
//    var selectedDate: String = ""
//    var notificationsNumber = Int()
//    var notifications = [String: [MyNotification]]()
//    
//    init(storageService: IStorageService = StorageService()){
//        self.storageService = storageService
//    }
//
//    func removeNotification(notification: MyNotification) {
//        let date = notification.date
//        
//        let removeNotification = notification
//        if let indexNotification = notifications[date]?.firstIndex(where: { notification in
//            notification.text == removeNotification.text
//        }) {
//            notifications[date]?.remove(at: indexNotification)
//            StorageService().saveNotification()
//        }
//    }
//
//    func addNotification(notification: MyNotification) {
//        if notifications[selectedDate] == nil {
//            notifications[selectedDate] = []
//        }
//        notifications[selectedDate]?.append(notification)
//        setNumber()
//        StorageService().saveNotification()
//        delegate?.updateData()
//    }
//    
//    func toggleNotificationState(notification: MyNotification) {
//        if let firstIndex = notifications[selectedDate]?.firstIndex(where: { myNotification in
//            myNotification.text == notification.text
//        }) {
//            notifications[selectedDate]?[firstIndex].state = !notification.state
//        }
//        StorageService().saveNotification()
//    }
//    
//    func setNumber() {
//        notificationsNumber += 1
//    }
//    
//    func getNumber() -> Int {
//        notificationsNumber
//    }
//    
//    func setDate(date: String) {
//        selectedDate = date
//    }
//    
//    func getDate() -> String {
//        selectedDate
//    }
//}
