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
    private var selectedDate = ""
    var notificationsNumber = Int()

    var notifications = [String: [Notification]]()
    
    
    func save() {
        let jsonEncoder = JSONEncoder()
        
        if let savedData = try? jsonEncoder.encode(notifications) {
            UserDefaults.standard.set(savedData, forKey: "notifications")
        } else {
            print("Failed to save notifications")
        }
    }
    
    func load() {
        if let savedNotifications = UserDefaults.standard.object(forKey: "notifications") as? Data {
            do { notifications = try JSONDecoder().decode([String: [Notification]].self, from: savedNotifications)
            } catch {
                print("Failed to load notifications")
            }
        }
    }


    func removeNotification(notification: Notification) {
        let date = notification.date
        
        let removeNotification = notification
        if let indexNotification = notifications[date]?.firstIndex(where: { notification in
            notification.text == removeNotification.text
        }) {
            notifications[date]?.remove(at: indexNotification)
        }
    }

    
    func addNotification(notification: Notification) {
        if notifications[selectedDate] == nil {
            notifications[selectedDate] = []
        }
        notifications[selectedDate]?.append(notification)
        setNumber()
        print(notification.number)
        save()
        delegate?.updateData()
    }
    
    func toggleNotificationState(notification: Notification) {
        print(notification.text )
        if let firstIndex = notifications[selectedDate]?.firstIndex(where: { myNotification in
            myNotification.text == notification.text
        }) {
            print(notifications[selectedDate]?[firstIndex].id ?? "ok")
            notifications[selectedDate]?[firstIndex].state = !notification.state
        }
        save()
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
