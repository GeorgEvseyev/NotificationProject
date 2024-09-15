//
//  MenuViewControllerMock.swift
//  NotificationProjectTests
//
//  Created by Георгий Евсеев on 15.09.24.
//

import Foundation
@testable import NotificationProject

final class MenuViewControllerMock: IMenuScreenController {
    
    var invokedSetLabelText = false
    var invokedSetLabelTextCount = 0
    var invokedSetLabelTextParameter: String!
    var invokedSetLabelTextParameterList: [String]! = []
    
    func setLabelText(_ text: String) {
        invokedSetLabelText = true
        invokedSetLabelTextCount += 1
        invokedSetLabelTextParameter = text
        invokedSetLabelTextParameterList.append(text)
    }
}
