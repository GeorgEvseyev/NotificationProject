//
//  SecondScreenAssembly.swift
//  DI
//
//  Created by Igor Lebedev on 31.03.24.
//

import UIKit

final class InclineScreenAssembly {

    func assemble(output: InclineScreenPresenterOutput) -> UIViewController {

        let presenter = InclineScreenPresenter(output: output)
        let controller = InclineScreenViewController(presenter: presenter)
        presenter.view = controller

        return controller
    }

}

