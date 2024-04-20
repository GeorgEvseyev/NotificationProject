//
//  SecondScreenAssembly.swift
//  DI
//
//  Created by Igor Lebedev on 31.03.24.
//

import UIKit

final class RegistrationScreenAssembly {

    func assemble(output: RegistrationScreenPresenterOutput) -> UIViewController {
        let storageService = StorageService()
        let presenter = RegistrationScreenPresenter(output: output, storageService: storageService)
        let controller = RegistrationScreenController(presenter: presenter)
        presenter.view = controller

        return controller
    }

}

