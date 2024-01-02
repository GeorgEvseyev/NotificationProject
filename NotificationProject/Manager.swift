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
    
    var notifications = [Notification(text: "asdaf"), Notification(text: "b"), Notification(text: "c"), Notification(text: "d"), Notification(text: "e")]
    
    func addNotification(index: Int, text: String) {
        notifications[index].text = text
    }
}





