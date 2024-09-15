//
//  RegistrationScreenAssemblyMock.swift
//  NotificationProjectTests
//
//  Created by Георгий Евсеев on 4.09.24.
//

@testable import NotificationProject
import Foundation

class RegistrationScreenAssemblyMock {
    
    var invokedAssemble = false
    var invokedAssembleCount = 0
    var invokedAssembleParameter: RegistrationScreenPresenterOutput!
    var invokedAssembleParameterList: [RegistrationScreenPresenterOutput] = []
    var stubbedAssembleResult: RegistrationScreenController!
    
    func assemble(output: RegistrationScreenPresenterOutput) -> RegistrationScreenController {
        invokedAssemble = true
        invokedAssembleCount += 1
        invokedAssembleParameter = output
        invokedAssembleParameterList.append(output)
        return stubbedAssembleResult
    }
}
