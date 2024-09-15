//
//  SomePresenterMock.swift
//  NotificationProjectTests
//
//  Created by Георгий Евсеев on 8.09.24.
//

import Foundation
@testable import NotificationProject

final class SomePresenterMock: ISomePresenter {
    
    var invokedFirst = false
    var invokedFirstCount = 0
    
    func first() {
        invokedFirst = true
        invokedFirstCount += 1
    }
    
    var invokedSecond = false
    var invokedSecondCount = 0
    var stubbedSecondResult: String!
    
    func second() -> String {
        invokedSecond = true
        invokedSecondCount += 1
        return stubbedSecondResult
    }
    
    var invokedThird = false
    var invokedThirdCount = 0
    var invokedThirdParameter: Int!
    var invokedThirdParameterList: [Int] = []
    
    func third(parameter: Int) {
        invokedThird = true
        invokedThirdCount += 1
        invokedThirdParameter = parameter
        invokedThirdParameterList.append(parameter)
    }
    
    var invokedFour = false
    var invokedFourCount = 0
    var invokedFourParameter: String!
    var invokedFourParameterList: [String] = []
    var stubbedFourResult: String!
    
    func four(parameter: String) -> String {
        invokedFour = true
        invokedFourCount += 1
        invokedFourParameter = parameter
        invokedFourParameterList.append(parameter)
        return stubbedFourResult
    }
}
