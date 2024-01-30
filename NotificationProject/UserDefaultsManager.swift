//
//  UserDefaultsManager.swift
//  NotificationProject
//
//  Created by Георгий Евсеев on 30.01.24.
//

import Foundation

final class UserDefaultsManager {
    
    static let shared = UserDefaultsManager()
    let defaults = UserDefaults.standard
    
    func save() {
        let jsonEncoder = JSONEncoder()

        if let savedData = try? jsonEncoder.encode(Manager.shared.notifications) {
            let defaults = UserDefaults.standard
            defaults.set(savedData, forKey: "notifications")
        } else {
            print("Failed to save Notifications")
        }
    }
    
    func load() {
        if let savedNotifications = defaults.object(forKey: "notifications") as? Data {
            let jsonDecoder = JSONDecoder()

            do {
                Manager.shared.notifications = try jsonDecoder.decode([Notification].self, from: savedNotifications)
                print("ok")
            } catch {
                print("Failed to load")
            }
        }
    }
}
