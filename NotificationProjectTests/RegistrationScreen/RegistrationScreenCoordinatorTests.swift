//
//  RegistrationScreenCoordinatorTests.swift
//  NotificationProjectTests
//
//  Created by Георгий Евсеев on 30.08.24.
//

import XCTest
@testable import NotificationProject

final class RegistrationScreenCoordinatorTests: XCTestCase {
    
    var sut: RegistrationScreenCoordinator!
    var mainScreenCoordinatorMock: MainScreenCoordinatorMock!

    override func setUpWithError() throws {
    sut = RegistrationScreenCoordinator()
    mainScreenCoordinatorMock = MainScreenCoordinatorMock()
    }

    override func tearDownWithError() throws {
    sut = nil
    mainScreenCoordinatorMock = nil
    }
    
    func test_start() {
        let request = "Test"
        mainScreenCoordinatorMock.start(request: request)
        
        XCTAssertTrue(mainScreenCoordinatorMock.invokedGetWindow)
        XCTAssertEqual(mainScreenCoordinatorMock.invokedGetWindowCount, 1)
    }
    
//    func test_enterButtonPressed() {
//        sut.enterButtonPressed()
//    }
//    
//    func test_exitButtonPressed() {
//        sut.exitButtonPressed()
//    }
    

}
