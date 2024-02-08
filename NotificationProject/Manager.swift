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

    var notifications = [Notification(date: 2024-02-08, number: 1, text: "asdaf", state: false), Notification(date: 2024-02-08, number: 1,text: "b", state: false), Notification(date: 2024-02-08, number: 1,text: "c", state: true), Notification(date: 2024-02-08, number: 1,text: "d", state: true), Notification(date: 2024-02-08, number: 1,text: "e", state: false)]
}
