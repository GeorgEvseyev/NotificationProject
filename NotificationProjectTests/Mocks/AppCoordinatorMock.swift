//
//  AppCoordinatorMock.swift
//  NotificationProjectTests
//
//  Created by Георгий Евсеев on 15.09.24.
//

import UIKit
import Foundation
@testable import NotificationProject

class AppCoordinatorMock {
    
    var invokedStart = false
    var invokedStartCount = 0
    var invokedStartParameter: UIWindow!
    
    func start(in window: UIWindow) {
        invokedStart = true
        invokedStartCount += 1
        invokedStartParameter = window
    }
}
