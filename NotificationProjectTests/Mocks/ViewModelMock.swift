//
//  ViewModelMock.swift
//  NotificationProjectTests
//
//  Created by Георгий Евсеев on 29.08.24.
//

import Foundation
@testable import NotificationProject

class ViewModelMock: IViewModel {
    
    var invokedGetNotifications = false
    var invokedGetNotificationsCount = 0
    var stubbedGetNotificationsResult: [NotificationProject.Notification]!
    
    func getNotifications() -> [NotificationProject.Notification] {
        invokedGetNotifications = true
        invokedGetNotificationsCount += 1
        return stubbedGetNotificationsResult
    }
    
    var invokedGetNotification = false
    var invokedGetNotificationCount = 0
    var stubbedGetNotificationResult: NotificationProject.Notification!
    func getNotification(index: Int) -> NotificationProject.Notification {
        invokedGetNotification = true
        invokedGetNotificationCount += 1
        return stubbedGetNotificationResult
    }
    
    var invokedGetFilteredNotification = false
    var invokedGetFilteredNotificationCount = 0
    var stubbedGetFilteredNotificationResult: [NotificationProject.Notification]!
    func getFilteredNotifications() -> [NotificationProject.Notification] {
        invokedGetFilteredNotification = true
        invokedGetFilteredNotificationCount += 1
        return stubbedGetFilteredNotificationResult
    }
    
    var invokedAddNotificationButtonPressed = false
    var invokedAddNotificationButtonPressedCount = 0
    func addNotificationButtonPressed() {
        invokedAddNotificationButtonPressed = true
        invokedAddNotificationButtonPressedCount += 1
    }
    
}
