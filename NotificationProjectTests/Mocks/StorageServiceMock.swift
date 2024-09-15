//
//  StorageServiceMock.swift
//  NotificationProjectTests
//
//  Created by Георгий Евсеев on 29.08.24.
//

import Foundation
@testable import NotificationProject

final class StorageServiceMock: IStorageService {
    
    var invokedGetNotifications = false
    var invokedGetNotificationsCount = 0
    
    func getNotification() {
        invokedGetNotifications = true
        invokedGetNotificationsCount += 1
    }
    
    var invokedSaveNotifications = false
    var invokedSaveNotificationsCount = 0
    
    func saveNotification() {
        invokedSaveNotifications = true
        invokedSaveNotificationsCount += 1
    }
}

