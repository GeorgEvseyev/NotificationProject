//
//  MenuScreenAssemblyMock.swift
//  NotificationProjectTests
//
//  Created by Георгий Евсеев on 15.09.24.
//

import Foundation
@testable import NotificationProject
import UIKit


final class MenuScreenAssemblyMock {
    
    var invokedAssemble = false
    var invokedAssembleCount = 0
    var invokedAssembleParameter: MenuScreenPresenterOutput!
    var invokedAssembleParameterList: [MenuScreenPresenterOutput]! = []
    var stubbedAssembleResult: UIViewController!
    
    func assemble(output: MenuScreenPresenterOutput) -> UIViewController {
        invokedAssemble = true
        invokedAssembleCount += 1
        invokedAssembleParameter = output
        return stubbedAssembleResult
    }
}
