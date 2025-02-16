//
//  MainScreenPresenterTests.swift
//  NotificationProjectTests
//
//  Created by Георгий Евсеев on 30.08.24.
//

import XCTest
@testable import NotificationProject

final class MainScreenPresenterTests: XCTestCase {
    

    var mainScreenCoordinatorMock: MainScreenCoordinatorMock!
    var viewModelMock: ViewModelMock!
    var sut: MainScreenPresenter!
    var manager: ManagerMock!

    override func setUpWithError() throws {
        mainScreenCoordinatorMock = MainScreenCoordinatorMock()
        viewModelMock = ViewModelMock()
        manager = ManagerMock()
        sut = MainScreenPresenter(output: mainScreenCoordinatorMock, viewModel: viewModelMock)
    }

    override func tearDownWithError() throws {
        sut = nil
        viewModelMock = nil
        mainScreenCoordinatorMock = nil
    }
    
//    func test_ButtonPressed() {
        // given

        
        // when
//        sut.buttonPressed()
        // then
//        
//        XCTAssertTrue(mainScreenCoordinatorMock.invokedButtonPressed)
//        XCTAssertEqual(mainScreenCoordinatorMock.invokedButtonPressedCount, 1)
//    }
    
    func test_CellButtonPressed() {
        // given

        // when
        sut.cellButtonPressed()
        
        // then
        XCTAssertTrue(mainScreenCoordinatorMock.invokedDetailButtonPressed)
        XCTAssertEqual(mainScreenCoordinatorMock.invokedDetailButtonPressedCount, 1)
    }
    
    func test_UserButtonPressed() {
        // given

        // when
        sut.userButtonPressed()
        
        // then
        XCTAssertTrue(mainScreenCoordinatorMock.invokedMoveToUserViewController)
        XCTAssertEqual(mainScreenCoordinatorMock.invokedMoveToUserViewControllerCount, 1)
    }
    
    func test_GetNotifications() {
        // given
        let expected = [NotificationProject.MyNotification(date: "some date", number: 0, text: "Some Text", state: true)]
        // when
        viewModelMock.stubbedGetNotificationsResult = expected
        let result = sut.getNotifications()
        
        // then
        XCTAssertTrue(viewModelMock.invokedGetNotifications)
        XCTAssertEqual(viewModelMock.invokedGetNotificationsCount, 1)
        XCTAssertEqual(result, expected)
    }
    
    func test_GetNotification() {
        // given
        let index = 0
        viewModelMock.invokedGetNotificationParameter = 0
        let expected = NotificationProject.MyNotification(date: "some date", number: 0, text: "Some Text", state: true)

        // when
        viewModelMock.stubbedGetNotificationResult = expected
        let result = sut.getNotification(index: index)
        
        // then
        XCTAssertTrue(viewModelMock.invokedGetNotification)
        XCTAssertEqual(viewModelMock.invokedGetNotificationCount, 1)
        XCTAssertEqual(result, expected)
        
        
    }
    
    func test_GetFilteredNotifications() {
        // given
        let expected = [NotificationProject.MyNotification(date: "some date", number: 0, text: "Some Text", state: true)]
        
        // when
        viewModelMock.stubbedGetFilteredNotificationResult = expected
        let result = sut.getFilteredNotifications()
        
        // then
        XCTAssertTrue(viewModelMock.invokedGetFilteredNotification)
        XCTAssertEqual(viewModelMock.invokedGetFilteredNotificationCount, 1)
        XCTAssertEqual(result, expected)
        
    }
    
    func test_AddNotificationButtonPressed() {
        // given

        // when
        viewModelMock.addNotificationButtonPressed()
        
        // then
        XCTAssertTrue(viewModelMock.invokedAddNotificationButtonPressed)
        XCTAssertEqual(viewModelMock.invokedAddNotificationButtonPressedCount, 1)
    }
    
    
    func test_SetDate() {
        // given
        let date = "some date"
        
        // when
        sut.setDate(date: date)
//        manager.setDate(date: date)
        
        // then
        XCTAssertTrue(manager.invokedSetDate)
        XCTAssertEqual(manager.invokedSetDateCount, 1)
        XCTAssertEqual(manager.invokedSetDateParameter, date)
    }
    
    func test_GetDate() {
        // given
        
        // when

        // then
        
    }
}
