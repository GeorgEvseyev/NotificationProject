//
//  RegistrationScreenControllerMock.swift
//  NotificationProjectTests
//
//  Created by Георгий Евсеев on 4.09.24.
//

@testable import NotificationProject
import Foundation

class RegistrationScreenControllerMock: IRegistrationScreenController {
    
    var invokedSetLabelText = false
    var invokedSetLabelTextCount = 0
    var invokedSetLabelTextParameter: String!
    
    func setLabelText(_ text: String) {
        invokedSetLabelText = true
        invokedSetLabelTextCount += 1
        invokedSetLabelTextParameter = text
    }
    
    var invokedSetupUI = false
    var invokedSetupUICount = 0
    
    func setupUI() {
        invokedSetupUI = true
        invokedSetupUICount += 1
    }
    
}
