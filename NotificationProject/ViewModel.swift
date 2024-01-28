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
        netWorkService.sendRequest { notification in
            self.delegate?.addNotification(notification: notification)
        }
    }
}
