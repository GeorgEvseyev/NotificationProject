//
//  RegistrationScreenPresenterMock.swift
//  NotificationProjectTests
//
//  Created by Георгий Евсеев on 4.09.24.
//

import Foundation
@testable import NotificationProject

class RegistrationScreenPresenterMock: IRegistrationScreenPresenter {
    
    var invokedButtonPressed = false
    var invokedButtonPressedCount = 0
    
    func buttonPressed() {
        invokedButtonPressed = true
        invokedButtonPressedCount += 1
    }
}
