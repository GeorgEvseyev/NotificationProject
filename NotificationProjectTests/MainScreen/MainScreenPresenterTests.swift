//
//  MainScreenPresenterTests.swift
//  NotificationProjectTests
//
//  Created by Георгий Евсеев on 30.08.24.
//

import XCTest
@testable import NotificationProject

final class MainScreenPresenterTests: XCTestCase {
    
    var sut: MainScreenPresenter!
    var viewModelMock: ViewModelMock!
    var mainScreenCoordinatorMock: MainScreenCoordinatorMock!
    var manager: ManagerMock!
    

    override func setUpWithError() throws {
        sut = MainScreenPresenter(output: mainScreenCoordinatorMock, viewModel: viewModelMock)
    }

    override func tearDownWithError() throws {
        sut = nil
        viewModelMock = nil
        mainScreenCoordinatorMock = nil
    }
    
    func test_ButtonPressed() {
        // given

        
        // when
        sut.buttonPressed()
        // then
        
        XCTAssertTrue(mainScreenCoordinatorMock.invokedButtonPressed)
        XCTAssertEqual(mainScreenCoordinatorMock.invokedButtonPressedCount, 1)
    }
    
    func test_CellButtonPressed() {
        // given
        
        
        // when
        mainScreenCoordinatorMock.detailButtonPressed()
        
        // then
        XCTAssertTrue(mainScreenCoordinatorMock.invokedDetailButtonPressed)
        XCTAssertEqual(mainScreenCoordinatorMock.invokedDetailButtonPressedCount, 1)
    }
    
    func test_UserButtonPressed() {
        // given

        // when
        mainScreenCoordinatorMock.moveToUserViewController()
        // then
        XCTAssertTrue(mainScreenCoordinatorMock.invokedMoveToUserViewController)
        XCTAssertEqual(mainScreenCoordinatorMock.invokedMoveToUserViewControllerCount, 1)
    }
    
    func test_GetFilteredNotifications() {
        // given

        
        // when
        viewModelMock.getFilteredNotifications()
        
        // then
        
        
    }
    
    func test_GetNotifications() {
        // given

        // when
        viewModelMock.getFilteredNotifications()
        // then
        
    }
    
    func test_GetNotification() {
        // given

        // when
        viewModelMock.getNotification(index: <#T##Int#>)
        // then
        
    }
    
    func test_AddNotificationButtonPressed() {
        // given

        // when
        viewModelMock.addNotificationButtonPressed()
        // then
        
    }
    
    func test_SetDate() {
        // given

        // when

        // then
        
    }
    
    func test_GetDate() {
        // given
        
        // when

        // then
        
    }
}
