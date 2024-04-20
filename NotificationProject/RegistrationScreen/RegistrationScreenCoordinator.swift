//
//  RegistrationScreenCoordinator.swift
//  NotificationProject
//
//  Created by Георгий Евсеев on 16.04.24.
//

import Foundation

import UIKit

protocol RegistrationScreenPresenterOutput: AnyObject {
    func enterButtonPressed()
}

protocol MainScreenPresenterOutput: AnyObject {
    func exitButtonPressed()
}

final class RegistrationScreenCoordinator {

    private var navigationController: UINavigationController?
    private var mainScreenCoordinator: MainScreenCoordinator?

    func start(in window: UIWindow) {
        let controller = RegistrationScreenAssembly().assemble(output: self)
        navigationController = UINavigationController(rootViewController: controller)
        navigationController?.setNavigationBarHidden(true, animated: false)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}

extension RegistrationScreenCoordinator: RegistrationScreenPresenterOutput {
    func enterButtonPressed() {
        mainScreenCoordinator = MainScreenCoordinator(navigationController: navigationController)
        if let  window = navigationController?.view.window {
            mainScreenCoordinator?.start(in: window)
        }
    }
}

extension RegistrationScreenCoordinator: MainScreenPresenterOutput {
    func exitButtonPressed() {
        navigationController?.popViewController(animated: true)
    }
}

