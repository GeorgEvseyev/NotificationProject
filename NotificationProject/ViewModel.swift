//
//  ViewModel.swift
//  NotificationProject
//
//  Created by Георгий Евсеев on 28.01.24.
//

import Foundation

protocol ViewModelDelegate: AnyObject {
    func updateView()
}

class ViewModel {
    weak var delegate: ViewModelDelegate?
    var netWorkService = NetworkService()

    func addNotificationButtonPressed() {

        let notification = Notification(date: Manager.shared.getDate(), number: Manager.shared.getNumber(), text: "", state: true)
        Manager.shared.addNotification(notification: notification)
        delegate?.updateView()
    }

    func getNotifications() -> [Notification] {
        let notifications = Manager.shared.notifications[Manager.shared.getDate()] ?? []
        return notifications
    }
    
    func getNotification(index: Int) -> Notification {
        return getNotifications()[index]
    }
    
    
    func getFilteredNotifications() -> [Notification] {
        Manager.shared.notifications[Manager.shared.getDate()]?.sort(by: { (n1, n2) -> Bool in
            if !n1.state && !n2.state {
                return n1.text < n2.text
            }
            return n1.state && !n2.state
        })
        return Manager.shared.notifications[Manager.shared.getDate()] ?? [Notification]()
    }
}
