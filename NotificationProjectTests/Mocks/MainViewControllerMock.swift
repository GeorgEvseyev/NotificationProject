//
//  MainViewControllerMock.swift
//  NotificationProjectTests
//
//  Created by Георгий Евсеев on 29.08.24.
//

@testable import NotificationProject
import Foundation

class MainViewControllerMock: IMainScreenController {
    
    var invokedSetLabelText = false
    var invokedSetLabelTextCount = 0
    var invokedSetLabekTextParameter: String!
    var invokedSetLabelTextParameterList: [String]! = []
    
    func setLabelText(_ text: String) {
        invokedSetLabelText = true
        invokedSetLabelTextCount += 1
        invokedSetLabekTextParameter = text
        invokedSetLabelTextParameterList.append(text)
    }
    
    var invokedSetupUI = false
    var invokedSetupUICount = 0
    
    func setupUI() {
        invokedSetupUI = true
        invokedSetupUICount += 1
    }
    
    var invokedButtonPressed = false
    var invokedButtonPressedCount = 0
    
    func buttonPressed() {
        invokedButtonPressed = true
        invokedButtonPressedCount += 1
    }
    
    var invokedAddNotificationButtonPressed = false
    var invokedAddNotificationButtonPressedCount = 0
    
    func addNotificationButtonPressed() {
        invokedAddNotificationButtonPressed = true
        invokedAddNotificationButtonPressedCount += 1
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
    
    var invokedShowCalendar = false
    var invokedShowCalendarCount = 0
    
    @objc func showCalendar() {
        invokedShowCalendar = true
        invokedShowCalendarCount += 1
    }
    
    var invokedHideCalendar = false
    var invokedHideCalendarCount = 0
    
    @objc func hideCalendar() {
        invokedHideCalendar = true
        invokedHideCalendarCount += 1
    }
    
    var invokedToggleButtonView = false
    var invokedToggleButtonViewCount = 0
    
    @objc func toggleButtonView() {
        invokedToggleButtonView = true
        invokedToggleButtonViewCount += 1
    }
    
    var invokedShowButtonView = false
    var invokedShowButtonViewCount = 0
    
    @objc func showButtonView() {
        invokedShowButtonView = true
        invokedShowButtonViewCount += 1
    }
    
    var invokedHideButtonView = false
    var invokedHideButtonViewCount = 0
    
    @objc func hideButtonView() {
        invokedHideButtonView = true
        invokedHideButtonViewCount += 1
    }
}
