//
//  StorageService.swift
//  NotificationProject
//
//  Created by Георгий Евсеев on 13.04.24.
//

import Foundation

protocol IStorageService {
    func getNotification()
    func saveNotification()
}

final class StorageService: IStorageService {

    func getNotification() {
//        if let getData = UserDefaults.standard.object(forKey: "notifications") as? Data {
//            if let decodedData = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(getData) as? [String:[Notification]] {
//                Manager.shared.notifications = decodedData
//                print("loadOk")
//            }
//        }
        
        if let savedNotifications = UserDefaults.standard.object(forKey: "notifications") as? Data {
            do { Manager.shared.notifications = try JSONDecoder().decode([String: [Notification]].self, from: savedNotifications)
            } catch {
                print("Failed to load notifications")
            }
        }
        
        
    }

    func saveNotification() {
//        if let savedData = try? NSKeyedArchiver.archivedData(withRootObject: Manager.shared.notifications, requiringSecureCoding: false) {
//            let defaults = UserDefaults.standard
//            defaults.set(savedData, forKey: "notifications")
//            print("SaveOk")
//        }
        
        let jsonEncoder = JSONEncoder()
        if let savedData = try? jsonEncoder.encode(Manager.shared.notifications) {
            UserDefaults.standard.set(savedData, forKey: "notifications")
        } else {
            print("Failed to save notifications")
        }
    }
}
