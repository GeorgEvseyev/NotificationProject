//
//  ExpensesScreenPresenterMock.swift
//  NotificationProjectTests
//
//  Created by Георгий Евсеев on 15.09.24.
//

import Foundation
@testable import NotificationProject

final class ExpensesScreenPresenterMock {
    
    var invokedButtonPressed = false
    var invokedButtonPressedCount = 0
    
    func buttonPressed() {
        invokedButtonPressed = true
        invokedButtonPressedCount += 1
    }
}
