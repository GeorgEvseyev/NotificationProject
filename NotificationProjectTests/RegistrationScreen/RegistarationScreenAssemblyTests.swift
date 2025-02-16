//
//  RegistarationScreenAssemblyTests.swift
//  NotificationProjectTests
//
//  Created by Георгий Евсеев on 4.09.24.
//

import XCTest
@testable import NotificationProject

final class RegistarationScreenAssemblyTests: XCTestCase {
    
    var sut: RegistrationScreenAssembly!
    var output: RegistrationScreenCoordinatorMock!
    var presenter: RegistrationScreenPresenterMock!
    

    override func setUpWithError() throws {

        sut = RegistrationScreenAssembly()
        output = RegistrationScreenCoordinatorMock()
        presenter = RegistrationScreenPresenterMock()
    }

    override func tearDownWithError() throws {
        sut = nil
        output = nil
    }
    
    //?
    
    func test_assemble() {
        let expected = RegistrationScreenController(presenter: presenter)
        let result = sut.assemble(output: output)
        
        XCTAssertEqual(result, expected)
    }

}
