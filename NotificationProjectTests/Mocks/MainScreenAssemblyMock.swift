//
//  MainScreenAssemblyMock.swift
//  NotificationProjectTests
//
//  Created by Георгий Евсеев on 15.09.24.
//

import UIKit
import Foundation
@testable import NotificationProject

final class MainScreenAssemblyMock {
    
    var invokedAssemble = false
    var invokedAssembleCount = 0
    var invokedAssemblePararmeter: MainPresenterOutput!
    var invokedAssemblePararmeterList: [MainPresenterOutput]! = []
    var stubbedAssembleResult: UIViewController!
    
    func assemble(output: MainPresenterOutput) -> UIViewController {
        invokedAssemble = true
        invokedAssembleCount += 1
        invokedAssemblePararmeter = output
        invokedAssemblePararmeterList.append(output)
        return stubbedAssembleResult
    }
    
}
