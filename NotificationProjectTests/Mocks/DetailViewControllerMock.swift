//
//  DetailViewControllerMock.swift
//  NotificationProjectTests
//
//  Created by Георгий Евсеев on 15.09.24.
//

import Foundation
@testable import NotificationProject

final class DetailViewControllerMock: IDetailScreenController {
    
    var invokedSetLabelText = false
    var invokedSetLabelTextCount = 0
    var invokedSetLabelTexrParameter: String!
    var invokedSetLabelTexrParameterList: [String]! = []
    
    func setLabelText(_ text: String) {
        invokedSetLabelText = true
        invokedSetLabelTextCount += 1
        invokedSetLabelTexrParameter = text
        invokedSetLabelTexrParameterList.append(text)
    }
    
    var invokedSetupUI = false
    var invokedSetupUICount = 0
    
    func setupUI() {
        invokedSetupUI = true
        invokedSetupUICount += 1
    }
    
    var invokeMoveFirstScreenController = false
    var invokeMoveFirstScreenControllerCount = 0
    
    @objc func moveFirstScreenController() {
        invokeMoveFirstScreenController = true
        invokeMoveFirstScreenControllerCount += 1
    }
}
