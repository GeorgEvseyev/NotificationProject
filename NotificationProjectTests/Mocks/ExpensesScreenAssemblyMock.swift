//
//  ExpensesScreenAssemblyMock.swift
//  NotificationProjectTests
//
//  Created by Георгий Евсеев on 15.09.24.
//

import Foundation
@testable import NotificationProject
import UIKit

final class ExpensesScreenAssemblyMock {
    
    var invokedAssemble = false
    var invokedAssembleCount = 0
    var invokedAssembleParameter: ExpensesScreenPresenterOutput!
    var invokedAssembleParameterList: [ExpensesScreenPresenterOutput]! = []
    var stubbedAssembleResult: UIViewController!
    
    func assemble(output: ExpensesScreenPresenterOutput) -> UIViewController {
        invokedAssemble = true
        invokedAssembleCount += 1
        invokedAssembleParameter = output
        return stubbedAssembleResult
    }
    
}
