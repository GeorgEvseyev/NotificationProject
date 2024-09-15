//
//  ManagerMock.swift
//  NotificationProjectTests
//
//  Created by Георгий Евсеев on 7.09.24.
//

@testable import NotificationProject
import Foundation

final class ManagerMock: IManager  {
    
    var invokedRemoveNotification = false
    var invokedRemoveNotificationCount = 0
    var invokedRemoveNotificationParameter: NotificationProject.Notification!
    var invokedRemoveNotificationParameterList: [NotificationProject.Notification] = []
    
    func removeNotification(notification: NotificationProject.Notification) {
        invokedRemoveNotification = true
        invokedRemoveNotificationCount += 1
        invokedRemoveNotificationParameter = notification
        invokedRemoveNotificationParameterList.append(notification)
    }

    var invokedAddNotification = false
    var invokedAddNotificationCount = 0
    var invokedAddNotificationParameter: NotificationProject.Notification!
    var invokedAddNotificationParameterList: [NotificationProject.Notification] = []
    
    func addNotification(notification: NotificationProject.Notification) {
        invokedAddNotification = false
        invokedAddNotificationCount += 1
        invokedAddNotificationParameter = notification
        invokedAddNotificationParameterList.append(notification)
    }
    
    var invokedToggleNotificationState = false
    var invokedToggleNotificationStateCount = 0
    var invokedToggleNotificationStateParameter: NotificationProject.Notification!
    var invokedToggleNotificationStateParameterList: [NotificationProject.Notification] = []
    
    func toggleNotificationState(notification: NotificationProject.Notification) {
        invokedToggleNotificationState = true
        invokedToggleNotificationStateCount += 1
        invokedAddNotificationParameter = notification
        invokedAddNotificationParameterList.append(notification)
    }
    
    var invokedSetNumber = false
    var invokedSetNumberCount = 0
    
    func setNumber() {
        invokedSetNumber = true
        invokedSetNumberCount += 1
    }
    
    var invokedGetNumber = false
    var invokedGetNumberCount = 0
    var stubbedGetNumberResult: Int!
    
    func getNumber() -> Int {
        invokedGetNumber = true
        invokedGetNumberCount += 1
        
        return stubbedGetNumberResult
    }
   
    var invokedSetDate = false
    var invokedSetDateCount = 0
    var invokedSetDateParameter: String!
    var invokedSetDateParameterList: [String] = []
    
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
