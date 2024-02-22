//
//  UserDefaultsManager.swift
//  NotificationProject
//
//  Created by Георгий Евсеев on 30.01.24.
//

import Foundation

final class UserDefaultsManager {
    
    static let shared = UserDefaultsManager()
    
    func save() {
        let jsonEncoder = JSONEncoder()

        if let savedData = try? jsonEncoder.encode(Manager.shared.notifications) {
            UserDefaults.standard.set(savedData, forKey: "notifications")
        } else {
            print("Failed to save Notifications")
        }
    }
    
    func load() {
        if let savedNotifications = UserDefaults.standard.object(forKey: "notifications") as? Data {

            do {
                Manager.shared.notifications = try JSONDecoder().decode([String: [Notification]].self, from: savedNotifications)
                print("ok")
            } catch {
                print("Failed to load")
            }
        }
    }
}
