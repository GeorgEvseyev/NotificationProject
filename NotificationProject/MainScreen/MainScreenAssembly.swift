//
//  FirstScreenAssembly.swift
//  NotificationProject
//
//  Created by Георгий Евсеев on 13.04.24.
//

import UIKit

final class MainScreenAssembly {

    func assemble(output: MainPresenterOutput) -> UIViewController {

        let storageService = StorageService()
        let viewModel = ViewModel()
        let presenter = MainScreenPresenter(output: output, viewModel: viewModel)
        let controller = MainScreenController(presenter: presenter)
        presenter.view = controller

        return controller
    }

}
