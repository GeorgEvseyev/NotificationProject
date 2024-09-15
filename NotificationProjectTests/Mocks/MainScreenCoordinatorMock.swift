//
//  MainScreenCoordinatorMock.swift
//  NotificationProjectTests
//
//  Created by Георгий Евсеев on 29.08.24.
//

import UIKit
import Foundation
@testable import NotificationProject

class MainScreenCoordinatorMock: MainPresenterOutput, DetailScreenPresenterOutput, MenuScreenPresenterOutput, UserScreenPresenterOutput, InclineScreenPresenterOutput, ExpensesScreenPresenterOutput {
    
    var invokedStart = false
    var invokedStartCount = 0
    var invokedStartParameter: UIWindow!
    
    func start(in window: UIWindow) {
        invokedStart = true
        invokedStartCount += 1
        invokedStartParameter = window
    }
    
    var invokedDetailButtonPressed = false
    var invokedDetailButtonPressedCount = 0
    
    
    func detailButtonPressed() {
        invokedDetailButtonPressed = true
        invokedDetailButtonPressedCount += 1
    }
    
    var invokedMoveToMenuViewController = false
    var invokedMoveToMenuViewControllerCount = 0
    
    func moveToMenuViewController() {
        invokedMoveToMenuViewController = true
        invokedMoveToMenuViewControllerCount += 1
    }
    
    var invokedMoveToUserViewController = false
    var invokedMoveToUserViewControllerCount = 0
    
    func moveToUserViewController() {
        invokedMoveToUserViewController = true
        invokedMoveToUserViewControllerCount += 1
    }
    
    var invokedMoveToInclineViewController = false
    var invokedMoveToInclineViewControllerCount = 0
    
    func moveToInclineViewController() {
        invokedMoveToInclineViewController = true
        invokedMoveToInclineViewControllerCount += 1
    }
    
    var invokedMoveToExpensesViewController = false
    var invokedMoveToExpensesViewControllerCount = 0
    
    func moveToExpensesViewController() {
    invokedMoveToExpensesViewController = true
    invokedMoveToExpensesViewControllerCount += 1
    }
    
    var invokedDetailScreenBackButtonPressed = false
    var invokedDetailScreenBackButtonPressedCount = 0
    
    func detailScreenBackButtonPressed() {
        invokedDetailScreenBackButtonPressed = true
        invokedDetailScreenBackButtonPressedCount += 1
    }
    
    var invokedMenuScreenBackButtonPressed = false
    var invokedMenuScreenBackButtonPressedCount = 0
    
    func menuScreenBackButtonPressed() {
        invokedMenuScreenBackButtonPressed = true
        invokedMenuScreenBackButtonPressedCount += 1
    }
    
    var invokedUserScreenBackButtonPressed = false
    var invokedUserScreenBackButtonPressedCount = 0
    
    func userScreenBackButtonPressed() {
        invokedUserScreenBackButtonPressed = true
        invokedUserScreenBackButtonPressedCount += 1
    }
    
    var invokedInclineScreenBackButtonPressed = false
    var invokedInclineScreenBackButtonPressedCount = 0
    
    func inclineScreenBackButtonPressed() {
        invokedInclineScreenBackButtonPressed = true
        invokedInclineScreenBackButtonPressedCount += 1
    }
    
    var invokedExpensesScreenBackButtonPressed = false
    var invokedExpensesScreenBackButtonPressedCount = 0
    
    func expensesScreenBackButtonPressed() {
        invokedExpensesScreenBackButtonPressed = true
        invokedExpensesScreenBackButtonPressedCount += 1
    }
    
}
