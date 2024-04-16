//
//  FirstScreenCoordinator.swift
//  NotificationProject
//
//  Created by Георгий Евсеев on 13.04.24.
//

import UIKit

protocol FirstScreenPresenterOutput: AnyObject {
    func navigationButtonPressed()
}

protocol SecondPresenterOutput: AnyObject {
    func backButtonPressed()
}

final class FirstScreenCoordinator {

    private var navigationController: UINavigationController?

    func start(in window: UIWindow) {
        let controller = FirstScreenAssembly().assemble(output: self)
        navigationController = UINavigationController(rootViewController: controller)
        navigationController?.setNavigationBarHidden(true, animated: false)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}

extension FirstScreenCoordinator: FirstScreenPresenterOutput {
    func navigationButtonPressed() {
        let presenter = SecondPresenter(output: self)
        let controller = SecondViewController(presenter: presenter)
        presenter.view = controller
        navigationController?.pushViewController(controller, animated: true)
    }
}

extension FirstScreenCoordinator: SecondPresenterOutput {
    func backButtonPressed() {
        navigationController?.popViewController(animated: true)
    }
}
