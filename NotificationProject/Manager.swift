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
    var notificationDate = String()
    var notificationNumber = Int()

    var notifications = [Notification]()

    func getFilteredNotifications() -> [Notification] {
        let notifications = notifications.filter { $0.date == notificationDate }
        return notifications
    }

    func removeNotification(notification: Notification) {
        let removeNotification = notification
        if let indexNotification = notifications.firstIndex(where: { notification in
            notification.text == removeNotification.text
        }) {
            notifications.remove(at: indexNotification)
        }
    }
}
