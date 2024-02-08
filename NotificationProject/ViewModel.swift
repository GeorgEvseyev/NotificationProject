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
        Manager.shared.notifications[index].state = !Manager.shared.notifications[index].state
        Manager.shared.delegate?.updateData()
    }
}
