//
//  UserScreenAssemblyMock.swift
//  NotificationProjectTests
//
//  Created by Георгий Евсеев on 15.09.24.
//

import Foundation
@testable import NotificationProject
import UIKit

final class UserScreenAssemblyMock {
    
    var invokedAssemble = false
    var invokedAssembleCount = 0
    var invokedAssembleParameter: UserScreenPresenterOutput!
    var invokedAssembleParameterList: [UserScreenPresenterOutput]! = []
    var stubbedAssembleResult: UIViewController!
    
    func assemble(output: UserScreenPresenterOutput) -> UIViewController {
        invokedAssemble = true
        invokedAssembleCount += 1
        invokedAssembleParameter = output
        return stubbedAssembleResult
    }
    
}
