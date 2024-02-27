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
        notifications[notificationDate]?.sort(by: { (n1, n2) -> Bool in
            if !n1.state && !n2.state {
                return n1.text < n2.text
            }
            return n1.state && !n2.state
        })
        return notifications[notificationDate] ?? [Notification]()
    }
    
    func getDate(date: String) {
        notificationDate = date
    }

}
