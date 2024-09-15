//
//  InclineScreenAssemblyMock.swift
//  NotificationProjectTests
//
//  Created by Георгий Евсеев on 15.09.24.
//

import Foundation
@testable import NotificationProject
import UIKit

final class InclineScreenAssemblyMock {
    
    var invokedAssemble = false
    var invokedAssembleCount = 0
    var invokedAssembleParameter: InclineScreenPresenterOutput!
    var invokedAssembleParameterList: [InclineScreenPresenterOutput]! = []
    var stubbedAssembleResult: UIViewController!
    
    func assemble(output: InclineScreenPresenterOutput) -> UIViewController {
        invokedAssemble = true
        invokedAssembleCount += 1
        invokedAssembleParameter = output
        return stubbedAssembleResult
    }
}
