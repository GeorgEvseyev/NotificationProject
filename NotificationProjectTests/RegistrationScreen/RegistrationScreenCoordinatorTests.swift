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
}
