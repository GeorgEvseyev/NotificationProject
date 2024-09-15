//
//  RegistrationScreenPresenterTests.swift
//  NotificationProjectTests
//
//  Created by Георгий Евсеев on 30.08.24.
//

import XCTest
@testable import NotificationProject

final class RegistrationScreenPresenterTests: XCTestCase {
    
    var sut: RegistrationScreenPresenter!
    var storageService: StorageServiceMock!
    var registrationScreenCoordinatorMock: RegistrationScreenCoordinatorMock!

    override func setUpWithError() throws {
        registrationScreenCoordinatorMock = RegistrationScreenCoordinatorMock()
        storageService = StorageServiceMock()
        sut = RegistrationScreenPresenter(output: registrationScreenCoordinatorMock, storageService: storageService)
    }

    override func tearDownWithError() throws {
        sut = nil
        storageService = nil
        registrationScreenCoordinatorMock = nil
    }
    
    func test_buttonPressed() {
        sut.buttonPressed()
        
        XCTAssertTrue(registrationScreenCoordinatorMock.invokedEnterButtonPressed)
        XCTAssertEqual(registrationScreenCoordinatorMock.invokedEnterButtonPressedCount, 1)
    }
}
