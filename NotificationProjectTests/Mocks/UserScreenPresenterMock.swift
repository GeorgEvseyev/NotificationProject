//
//  UserScreenPresenterMock.swift
//  NotificationProjectTests
//
//  Created by Георгий Евсеев on 15.09.24.
//

import Foundation
@testable import NotificationProject

final class UserScreenPresenterMock {
    
    var invokeButtonPressed = false
    var invokeButtonPressedCount = 0
    
    func buttonPressed() {
        invokeButtonPressed = true
        invokeButtonPressedCount += 1
    }
}
