//
//  DetailScreenAssemblyMock.swift
//  NotificationProjectTests
//
//  Created by Георгий Евсеев on 15.09.24.
//

import Foundation
@testable import NotificationProject
import UIKit

final class DetailScreenAssemblyMock {
    
    var invokedAssemble = false
    var invokedAssembleCount = 0
    var invokedAssembleParameter: DetailScreenPresenterOutput!
    var invokedAssembleParameterList: [DetailScreenPresenterOutput]! = []
    var stubbedAssembleResult: UIViewController!
    
    func assemble(output: DetailScreenPresenterOutput) -> UIViewController {
        invokedAssemble = true
        invokedAssembleCount += 1
        invokedAssembleParameter = output
        return stubbedAssembleResult
    }
}
