//
//  StorageService.swift
//  NotificationProject
//
//  Created by Георгий Евсеев on 13.04.24.
//

import Foundation

protocol IStorageService {
    func loadNotifications() -> [String: [MyNotification]]
    func saveNotifications(_ notifications: [String: [MyNotification]])
}

final class StorageService: IStorageService {
    private let key = "notifications"

    func loadNotifications() -> [String: [MyNotification]] {
        guard let savedData = UserDefaults.standard.data(forKey: key) else { return [:] }
        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            return try decoder.decode([String: [MyNotification]].self, from: savedData)
        } catch {
            print("❌ Failed to load notifications: \(error)")
            return [:]
        }
    }

    func saveNotifications(_ notifications: [String: [MyNotification]]) {
        do {
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .iso8601
            let data = try encoder.encode(notifications)
            UserDefaults.standard.set(data, forKey: key)
        } catch {
            print("❌ Failed to save notifications: \(error)")
        }
    }
}

////
////  StorageService.swift
////  NotificationProject
////
////  Created by Георгий Евсеев on 13.04.24.
////
//
//import Foundation
//
//protocol IStorageService {
//    func getNotification()
//    func saveNotification()
//}
//
//final class StorageService: IStorageService {
//
//    func getNotification() {
////        if let getData = UserDefaults.standard.object(forKey: "notifications") as? Data {
////            if let decodedData = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(getData) as? [String:[Notification]] {
////                Manager.shared.notifications = decodedData
////                print("loadOk")
////            }
////        }
//        
//        if let savedNotifications = UserDefaults.standard.object(forKey: "notifications") as? Data {
//            do { Manager.shared.notifications = try JSONDecoder().decode([String: [MyNotification]].self, from: savedNotifications)
//            } catch {
//                print("Failed to load notifications")
//            }
//        }
//        
//        
//    }
//
//    func saveNotification() {
////        if let savedData = try? NSKeyedArchiver.archivedData(withRootObject: Manager.shared.notifications, requiringSecureCoding: false) {
////            let defaults = UserDefaults.standard
////            defaults.set(savedData, forKey: "notifications")
////            print("SaveOk")
////        }
//        
//        let jsonEncoder = JSONEncoder()
//        if let savedData = try? jsonEncoder.encode(Manager.shared.notifications) {
//            UserDefaults.standard.set(savedData, forKey: "notifications")
//        } else {
//            print("Failed to save notifications")
//        }
//    }
//}
