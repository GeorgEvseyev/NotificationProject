//
//  DetailScreenAssembly.swift
//  NotificationProject
//
//  Created by Георгий Евсеев on 13.04.24.
//

import UIKit

final class DetailScreenAssembly {

    func assemble(output: DetailScreenPresenterOutput) -> UIViewController {

        let presenter = DetailScreenPresenter(output: output)
        let controller = DetailScreenViewController(presenter: presenter)
        presenter.view = controller

        return controller
    }

}

