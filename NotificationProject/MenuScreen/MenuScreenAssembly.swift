//
//  SecondScreenAssembly.swift
//  DI
//
//  Created by Igor Lebedev on 31.03.24.
//

import UIKit

final class MenuScreenAssembly {

    func assemble(output: MenuScreenPresenterOutput) -> UIViewController {

        let presenter = MenuScreenPresenter(output: output)
        let controller = MenuScreenViewController(presenter: presenter)
        presenter.view = controller

        return controller
    }

}

