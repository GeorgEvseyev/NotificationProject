//
//  FirstScreenCoordinator.swift
//  NotificationProject
//
//  Created by Георгий Евсеев on 13.04.24.
//

import UIKit

protocol FirstScreenPresenterOutput: AnyObject {
    func detailButtonPressed()
}

protocol DetailPresenterOutput: AnyObject {
    func backButtonPressed()
}

protocol UserPresenterOutput: AnyObject {
    func moveToUserViewController()
}

protocol InclinePresenterOutput: AnyObject {
    func moveToInclineViewController()
}

protocol ExpensesPresenterOutput: AnyObject {
    func moveToExpensesViewController()
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
    func detailButtonPressed() {
        let presenter = DetailPresenter(output: self)
        let controller = DetailViewController(presenter: presenter)
        presenter.view = controller
        navigationController?.pushViewController(controller, animated: true)
    }
}

extension FirstScreenCoordinator: DetailPresenterOutput {
    func backButtonPressed() {
        navigationController?.popViewController(animated: true)
    }
}

extension FirstScreenCoordinator: UserPresenterOutput {
    func moveToUserViewController() {
        let vc = UserViewController()
        navigationController?.present(vc, animated: true)
    }
}

extension FirstScreenCoordinator: InclinePresenterOutput {
    func moveToInclineViewController() {
        let vc = InclineViewController()
        navigationController?.present(vc, animated: true)
    }
}

extension FirstScreenCoordinator: ExpensesPresenterOutput {
    func moveToExpensesViewController() {
        let vc = ExpensesViewController()
        navigationController?.present(vc, animated: true)
    }
}
