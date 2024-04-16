//
//  SecondScreenAssembly.swift
//  NotificationProject
//
//  Created by Георгий Евсеев on 13.04.24.
//

import UIKit

final class SecondScreenAssembly {

    func assemble(output: SecondPresenterOutput) -> UIViewController {

        let presenter = SecondPresenter(output: output)
        let controller = SecondViewController(presenter: presenter)
        presenter.view = controller

        return controller
    }

}

