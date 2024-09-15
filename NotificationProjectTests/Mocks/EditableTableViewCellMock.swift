//
//  EditableTableViewCellMock.swift
//  NotificationProjectTests
//
//  Created by Георгий Евсеев on 14.09.24.
//

import Foundation
@testable import NotificationProject

final class EditableTableViewCellMock: IEditableTableViewCell {
    
    var invokedChecked = false
    var invokedCheckedCount = 0
    var invokedCheckedParameter: String!
    var invokedChekedParameterList: [String] = []
    var stabbedCheckedResult: NSMutableAttributedString!
    func checked(text: String) -> NSMutableAttributedString {
        invokedChecked = true
        invokedCheckedCount += 1
        invokedCheckedParameter = text
        invokedChekedParameterList.append(text)
        return stabbedCheckedResult
    }
    
    var invokedSetupCell = false
    var invokedSetupCellCount = 0
    func setupCell() {
        invokedSetupCell = true
        invokedSetupCellCount += 1
    }
    
    var invokedConfigure = false
    var invokedConfigureCount = 0
    var invokedConfigureNotificationParameter: NotificationProject.Notification!
    var invokedConfigureNotificationParameterList: [NotificationProject.Notification] = []
    var invokedConfigureIndexParameter: Int!
    var invokedConfigureIndexParameterList: [Int] = []
    
    func configure(notification: NotificationProject.Notification, index: Int) {
        invokedConfigure = true
        invokedConfigureCount += 1
        invokedConfigureNotificationParameter = notification
        invokedConfigureNotificationParameterList.append(notification)
        invokedConfigureIndexParameter = index
        invokedConfigureIndexParameterList.append(index)
    }
    
    var invokedConfigureButton = false
    var invokedConfigureButtonCount = 0
    func configureButton(with closure: @escaping () -> Void) {
        invokedConfigureButton = true
        invokedConfigureButtonCount += 1
    }
    
    var invokedConfigureDetailButton = false
    var invokedConfigureDetailButtonCount = 0
    func configureDetailButton(with closure: @escaping () -> Void) {
        invokedConfigureDetailButton = true
        invokedConfigureDetailButtonCount += 1
    }
    
    var invokedCheckButtonTapped = false
    var invokedCheckButtonTappedCount = 0
    func checkButtonTapped() {
        invokedCheckButtonTapped = true
        invokedCheckButtonTappedCount += 1
    }
    
    var invokedDetailButtonTapped = false
    var invokedDetailButtonTappedCount = 0
    func detailButtonTapped() {
        invokedDetailButtonTapped = true
        invokedDetailButtonTappedCount += 1
    }
}
