//
//  ViewModel.swift
//  NotificationProject
//
//  Created by Георгий Евсеев on 28.01.24.
//

import Foundation

protocol ViewModelDelegate: AnyObject {
    func addNotification(notification: Notification)
}

class ViewModel {
    weak var delegate: ViewModelDelegate?
    var netWorkService = NetworkService()

    func addNotificationButtonPressed() {
        netWorkService.sendRequest(completion: { notification in
            self.delegate?.addNotification(notification: notification)
        })
        Manager.shared.delegate?.updateData()
    }

    func toggleNotificationState(index: Int) {
        if Manager.shared.notifications[Manager.shared.notificationDate]?[index].state == true {
            Manager.shared.notifications[Manager.shared.notificationDate]?[index].state = false
        } else {
            Manager.shared.notifications[Manager.shared.notificationDate]?[index].state = true
        }
        Manager.shared.delegate?.updateData()
    }
}
