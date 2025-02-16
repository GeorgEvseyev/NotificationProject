//
//  RegistrationScreenViewControllerTests.swift
//  NotificationProjectTests
//
//  Created by Георгий Евсеев on 7.10.24.
//

@testable import NotificationProject
import XCTest

final class RegistrationScreenViewControllerTests: XCTestCase {
    
    var sut: RegistrationScreenController!
    var presenter: RegistrationScreenPresenterMock!
    
    
    override func setUpWithError() throws {
        presenter = RegistrationScreenPresenterMock()
        sut = RegistrationScreenController(presenter: presenter)
    }

    override func tearDownWithError() throws {
        presenter = nil
        sut = nil
    }
    
    func test_setLabelText() {
        
    }
}
    
