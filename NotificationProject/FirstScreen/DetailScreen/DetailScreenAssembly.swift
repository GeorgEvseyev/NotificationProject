//
//  DetailScreenAssembly.swift
//  NotificationProject
//
//  Created by Георгий Евсеев on 13.04.24.
//

import UIKit

final class DetailScreenAssembly {

    func assemble(output: SecondPresenterOutput) -> UIViewController {

        let presenter = SecondPresenter(output: output)
        let controller = SecondViewController(presenter: presenter)
        presenter.view = controller

        return controller
    }

}

