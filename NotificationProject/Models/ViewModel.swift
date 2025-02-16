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

protocol IViewModel: AnyObject {
    func getNotifications() -> [MyNotification]
    func getNotification(index: Int) -> MyNotification
    func getFilteredNotifications() -> [MyNotification]
    func addNotificationButtonPressed()
}

class ViewModel {
    weak var delegate: ViewModelDelegate?

}

extension ViewModel: IViewModel {
    func getNotifications() -> [MyNotification] {
        let notifications = Manager.shared.notifications[Manager.shared.getDate()] ?? []
        return notifications
    }
    
    func getNotification(index: Int) -> MyNotification {
        return getNotifications()[index]
    }
    
    func getFilteredNotifications() -> [MyNotification] {
        Manager.shared.notifications[Manager.shared.getDate()]?.sort(by: { (n1, n2) -> Bool in
            if !n1.state && !n2.state {
                return n1.text < n2.text
            }
            return n1.state && !n2.state
        })
        return Manager.shared.notifications[Manager.shared.getDate()] ?? [MyNotification]()
    }
    
    func addNotificationButtonPressed() {
        let notification = MyNotification(date: Manager.shared.getDate(), number: Manager.shared.getNumber(), text: "", state: true)
        Manager.shared.addNotification(notification: notification)
        delegate?.updateView()
    }
}
