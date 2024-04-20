//
//  SecondScreenAssembly.swift
//  DI
//
//  Created by Igor Lebedev on 31.03.24.
//

import UIKit

final class UserScreenAssembly {

    func assemble(output: UserScreenPresenterOutput) -> UIViewController {

        let presenter = UserScreenPresenter(output: output)
        let controller = UserScreenViewController(presenter: presenter)
        presenter.view = controller

        return controller
    }

}

