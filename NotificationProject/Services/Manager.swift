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

protocol IManager {
    func removeNotification(notification: Notification)
    func addNotification(notification: Notification)
    func toggleNotificationState(notification: Notification)
    func setNumber()
    func getNumber() -> Int
    func setDate(date: String)
    func getDate() -> String
}

final class Manager {
    static let shared = Manager()
    weak var delegate: ManagerDelegate?
    var selectedDate = ""
    var notificationsNumber = Int()

    var notifications = [String: [Notification]]()

    func removeNotification(notification: Notification) {
        let date = notification.date
        
        let removeNotification = notification
        if let indexNotification = notifications[date]?.firstIndex(where: { notification in
            notification.text == removeNotification.text
        }) {
            notifications[date]?.remove(at: indexNotification)
            StorageService().saveNotification()
        }
    }

    func addNotification(notification: Notification) {
        if notifications[selectedDate] == nil {
            notifications[selectedDate] = []
        }
        notifications[selectedDate]?.append(notification)
        setNumber()
        StorageService().saveNotification()
        delegate?.updateData()
    }
    
    func toggleNotificationState(notification: Notification) {
        if let firstIndex = notifications[selectedDate]?.firstIndex(where: { myNotification in
            myNotification.text == notification.text
        }) {
            notifications[selectedDate]?[firstIndex].state = !notification.state
        }
        StorageService().saveNotification()
    }
    
    func setNumber() {
        notificationsNumber += 1
    }
    
    func getNumber() -> Int {
        notificationsNumber
    }
    
    func setDate(date: String) {
        selectedDate = date
    }
    
    func getDate() -> String {
        selectedDate
    }
}
