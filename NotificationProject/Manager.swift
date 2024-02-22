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
    var notificationsNumber = Int()

    var notifications = [String: [Notification]]()
    


    func removeNotification(notification: Notification) {
        let date = notification.date
        
        let removeNotification = notification
        if let indexNotification = notifications[date]?.firstIndex(where: { notification in
            notification.text == removeNotification.text
        }) {
            notifications[date]?.remove(at: indexNotification)
        }
    }
    
    func getFilteredNotifications() -> [Notification] {
        return notifications[notificationDate]?.filter { $0.date == notificationDate }.sorted { $0.state && !$1.state } ?? [Notification]()
    }
    
    func getDate(date: String) {
        notificationDate = date
    }

}
