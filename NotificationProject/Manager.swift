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
    
    var notifications = [Notification(text: "asdaf", state: false), Notification(text: "b", state: false), Notification(text: "c", state: true), Notification(text: "d", state: true), Notification(text: "e", state: false)]
    
    func addNotification(index: Int, text: String) {
        notifications[index].text = text
    }
}





