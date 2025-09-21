//
//  ManagerTests.swift
//  NotificationProjectTests
//
//  Created by Георгий Евсеев on 17.11.24.
//

import XCTest
@testable import NotificationProject

final class ManagerTests: XCTestCase {
    
    var sut: Manager!
    var storageService: StorageServiceMock!
    var notifications: [String: [MyNotification]]!

    override func setUpWithError() throws {
        sut = Manager()
        storageService = StorageServiceMock()
        notifications = [:]
    }

    override func tearDownWithError() throws {
        sut = nil
        storageService = nil
        notifications = nil
    }
    
    func test_RemoveNotification() {
        let notification = MyNotification(date: "Date", number: 1, text: "Text", state: true)
        let result = sut.removeNotification(notification: notification)
    }
    
    func test_Add_Notification() {
        let notification = MyNotification(date: "Date", number: 1, text: "Text", state: true)
        notifications["My Notification"] = [notification]
    }
    
    func test_ToggleNotificationState() {
        
    }
    
    func test_SetNumber() {
        
    }
    
    func test_GetNumber() {
        
    }
    
    func test_SetDate() {
        
    }
    
    func test_GetDate() {
        
    }
}
