//
//  Manager.swift
//  NotificationProject
//
//  Created by Георгий Евсеев on 5.12.23.
//

import Foundation
import UIKit

protocol ManagerDelegate: AnyObject {
    func updateData()
}

final class Manager {
    static let shared = Manager()
    weak var delegate: ManagerDelegate?
    var notificationDate: String?
    var notificationNumber = Int()

    var notifications = [Notification]()

//    func getFilteredNotifications(date: String) -> [Notification] {
//        let notifications = notifications.filter { $0.date == date }
//        print("\(notifications) + 1")
//        return notifications
//    }

    func removeNotification(notification: Notification) {
        let removeNotification = notification
        if let indexNotification = notifications.firstIndex(where: { notification in
            notification.text == removeNotification.text
        }) {
            notifications.remove(at: indexNotification)
        }
    }
    
    func getFilteredNotifications(notifications: [Notification], date: String) -> [Notification] {
        let filteredNotifications = notifications.filter { $0.date == date }
        print(date)
        return filteredNotifications
    }
}
