//
//  RegistrationScreenCoordinatorMock.swift
//  NotificationProjectTests
//
//  Created by Георгий Евсеев on 30.08.24.
//

import UIKit
import Foundation
@testable import NotificationProject

class RegistrationScreenCoordinatorMock: RegistrationScreenPresenterOutput, MainScreenPresenterOutput {
    
    var invokedStart = false
    var invokedStartCount = 0
    var invokedStartParameter: UIWindow!
    
    func start(in window: UIWindow) {
        invokedStart = true
        invokedStartCount += 1
        invokedStartParameter = window
    }
    
    var invokedEnterButtonPressed = false
    var invokedEnterButtonPressedCount = 0
    
    func enterButtonPressed() {
        invokedEnterButtonPressed = true
        invokedEnterButtonPressedCount += 1
    }
    
    var invokedExitButtonPressed = false
    var invokedExitButtonPressedCount = 0
    
    func exitButtonPressed() {
        invokedExitButtonPressed = true
        invokedExitButtonPressedCount += 1
    }
}
