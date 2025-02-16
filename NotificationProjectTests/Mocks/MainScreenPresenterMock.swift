//
//  MainScreenPresenterMock.swift
//  NotificationProjectTests
//
//  Created by Георгий Евсеев on 29.08.24.
//

import Foundation
@testable import NotificationProject

class ManScreenPresenterMock: IMainScreenPresenter {
    
    var invokedButtonPressed = false
    var invokedButtonPressedCount = 0
    
    func buttonPressed() {
        invokedButtonPressed = true
        invokedButtonPressedCount += 1
    }
    
    var invokedCellButtonPressed = false
    var invokedCellButtonPressedCount = 0
    
    func cellButtonPressed() {
        invokedCellButtonPressed = true
        invokedCellButtonPressedCount += 1
    }
    
    
    var invokedUserButtonPressed = false
    var invokedUserButtonPressedCount = 0
    
    func userButtonPressed() {
        invokedUserButtonPressed = true
        invokedUserButtonPressedCount += 1
    }
    
    var invokedGetNotifications = false
    var invokedGetNotificationsCount = 0
    var stubbedGetNotificationsResult: [NotificationProject.MyNotification]! = []
    
    
    func getNotifications() -> [NotificationProject.MyNotification] {
        invokedGetNotifications = true
        invokedGetNotificationsCount += 1
        return stubbedGetNotificationsResult
    }
    
    var invokedGetNotification = false
    var invokedGetNotificationCount = 0
    var invokedGetNotificationParameter: Int!
    var invokedGetNotificationParameterList: [Int]! = []
    var stubbedGHetNotificationResult: NotificationProject.MyNotification!
    
    
    func getNotification(index: Int) -> NotificationProject.MyNotification {
        invokedGetNotification = true
        invokedGetNotificationCount += 1
        invokedGetNotificationParameter = index
        invokedGetNotificationParameterList.append(index)
        return stubbedGHetNotificationResult
    }
    
    var invokedGetFilteredNotifications = false
    var invokedGetFilteredNotificationsCount = 0
    var stubbedGetFilteredNotificationsResult: [NotificationProject.MyNotification]! = []
    
    func getFilteredNotifications() -> [NotificationProject.MyNotification] {
        invokedGetFilteredNotifications = true
        invokedGetFilteredNotificationsCount += 1
        return stubbedGetFilteredNotificationsResult
    }
    
    var invokedAddNotificationButtonPressed = false
    var invokedAddNotificationButtonPressedCount = 0
    
    
    func addNotificationButtonPressed() {
        invokedAddNotificationButtonPressed = true
        invokedAddNotificationButtonPressedCount += 1
    }
    
    var invokedSetDate = false
    var invokedSetDateCount = 0
    var invokedSetDateParameter: String!
    var invokedSetDateParameterList: [String]! = []
    
    func setDate(date: String) {
        invokedSetDate = true
        invokedSetDateCount += 1
        invokedSetDateParameter = date
        invokedSetDateParameterList.append(date)
    }
    
    var invokedGetDate = false
    var invokedGetDateCount = 0
    var stubbedGetDateResult: String!
    
    func getDate() -> String {
        invokedGetDate = true
        invokedGetDateCount += 1
        return stubbedGetDateResult
    }
}
