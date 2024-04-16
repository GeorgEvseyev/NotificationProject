//
//  FirstScreenAssembly.swift
//  NotificationProject
//
//  Created by Георгий Евсеев on 13.04.24.
//

import UIKit

final class FirstScreenAssembly {

    func assemble(output: FirstScreenPresenterOutput) -> UIViewController {

        let storageService = StorageService()
        let presenter = FirstScreenPresenter(
            output: output,
            storageService: storageService
        )
        let controller = FirstScreenController(presenter: presenter)
        presenter.view = controller

        return controller
    }

}
