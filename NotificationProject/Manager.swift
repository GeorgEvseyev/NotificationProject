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
//    let defaults = UserDefaults.standard
    static let shared = Manager()
    weak var delegate: ManagerDelegate?

    var notifications = [Notification(text: "asdaf", state: false), Notification(text: "b", state: false), Notification(text: "c", state: true), Notification(text: "d", state: true), Notification(text: "e", state: false)]

    func toggleButtonImage(index: Int) {
        Manager.shared.notifications[index].state = !Manager.shared.notifications[index].state
    }
}

extension Manager: ViewControllerDelegate {
    func addNotification() {
        notifications.append(Notification(text: "smt text", state: true))
        delegate?.updateData()
//        defaults.set(notifications, forKey: "SavedNotifications")
    }

    func addNotificationText(index: Int, text: String) {
        notifications[index].text = text
        delegate?.updateData()
//        defaults.set(self.notifications, forKey: "SavedNotifications")

    }
    
//    func loadNotifications() {
//        let savedNotifications = defaults.array(forKey: "SavedNotifications") as? [Notification]? ?? []
//        notifications = savedNotifications ?? notifications
//    }
}
