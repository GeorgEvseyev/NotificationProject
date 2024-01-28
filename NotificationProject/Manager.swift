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

    let defaults = UserDefaults.standard

    var notifications = [Notification(text: "asdaf", state: false), Notification(text: "b", state: false), Notification(text: "c", state: true), Notification(text: "d", state: true), Notification(text: "e", state: false)]

    func toggleButtonImage(index: Int) {
        Manager.shared.notifications[index].state = !Manager.shared.notifications[index].state
    }
}

extension Manager: ViewControllerDelegate {
    func addNotificationText(index: Int, text: String) {
        notifications[index].text = text
        save()
        delegate?.updateData()
    }

    func save() {
        let jsonEncoder = JSONEncoder()

        if let savedData = try? jsonEncoder.encode(Manager.shared.notifications) {
            let defaults = UserDefaults.standard
            defaults.set(savedData, forKey: "notifications")
        } else {
            print("Failed to save Notifications")
        }
    }
}
