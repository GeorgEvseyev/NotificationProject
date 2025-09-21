//
//  FirstScreenCoordinator.swift
//  NotificationProject
//
//  Created by Георгий Евсеев on 13.04.24.
//

import UIKit


protocol MainPresenterOutput: AnyObject {
    func detailButtonPressed()
    func moveToMenuViewController()
    func moveToUserViewController()
    func moveToInclineViewController()
    func moveToExpensesViewController()
    
}

protocol DetailScreenPresenterOutput: AnyObject {
    func detailScreenBackButtonPressed()
}

protocol MenuScreenPresenterOutput: AnyObject {
    func menuScreenBackButtonPressed()
}

protocol UserScreenPresenterOutput: AnyObject {
    func userScreenBackButtonPressed()
}

protocol InclineScreenPresenterOutput: AnyObject {
    func inclineScreenBackButtonPressed()
}

protocol ExpensesScreenPresenterOutput: AnyObject {
    func expensesScreenBackButtonPressed()
}

//final class MainScreenCoordinator {
//
//    private var navigationController: UINavigationController?
//    
//    init(navigationController: UINavigationController?) {
//        self.navigationController = navigationController
//    }
//
//    func start(in window: UIWindow) {
//        let controller = MainScreenAssembly().assemble(output: self)
//        navigationController = UINavigationController(rootViewController: controller)
//        navigationController?.setNavigationBarHidden(true, animated: false)
//        window.rootViewController = navigationController
//        window.makeKeyAndVisible()
//    }
//}

//final class MainScreenCoordinator {
//    private weak var navigationController: UINavigationController?
//    var onExit: (() -> Void)?
//
//    init(navigationController: UINavigationController?) {
//        self.navigationController = navigationController
//    }
//
//    func start() {
//        let controller = MainScreenAssembly().assemble(output: self)
//        navigationController?.pushViewController(controller, animated: true)
//    }
//}
//
//extension MainScreenCoordinator: MainScreenPresenterOutput {
//    func exitButtonPressed() {
//        onExit?()
//    }
//}
//
//
//extension MainScreenCoordinator: MainPresenterOutput {
//    func detailButtonPressed() {
//        let presenter = DetailScreenPresenter(output: self)
//        let controller = DetailScreenViewController(presenter: presenter)
//        presenter.view = controller
//        navigationController?.pushViewController(controller, animated: true)
//    }
//    
//    func moveToMenuViewController() {
//        let presenter = MenuScreenPresenter(output: self)
//        let controller = MenuScreenViewController(presenter: presenter)
//        presenter.view = controller
//        navigationController?.pushViewController(controller, animated: true)
//    }
//    
//    func moveToUserViewController() {
//        let presenter = UserScreenPresenter(output: self)
//        let controller = UserScreenViewController(presenter: presenter)
//        presenter.view = controller
//        navigationController?.present(controller, animated: true)
//    }
//    
//    func moveToInclineViewController() {
//        let presenter = InclineScreenPresenter(output: self)
//        let controller = InclineScreenViewController(presenter: presenter)
//        presenter.view = controller
//        navigationController?.present(controller, animated: true)
//    }
//    
//    func moveToExpensesViewController() {
//        let presenter = ExpensesScreenPresenter(output: self)
//        let controller = ExpensesScreenViewController(presenter: presenter)
//        presenter.view = controller
//        navigationController?.present(controller, animated: true)
//    }
//}
//
//extension MainScreenCoordinator: DetailScreenPresenterOutput {
//    func detailScreenBackButtonPressed() {
//        navigationController?.popViewController(animated: true)
//    }
//}
//
//extension MainScreenCoordinator: MenuScreenPresenterOutput {
//    func menuScreenBackButtonPressed() {
//        navigationController?.popViewController(animated: true)
//    }
//}
//
//extension MainScreenCoordinator: UserScreenPresenterOutput {
//    func userScreenBackButtonPressed() {
//        navigationController?.popViewController(animated: true)
//    }
//}
//
//extension MainScreenCoordinator: InclineScreenPresenterOutput {
//    func inclineScreenBackButtonPressed() {
//        navigationController?.popViewController(animated: true)
//    }
//}
//
//extension MainScreenCoordinator: ExpensesScreenPresenterOutput {
//    func expensesScreenBackButtonPressed() {
//        navigationController?.popViewController(animated: true)
//    }
//}

final class MainScreenCoordinator {
    private weak var navigationController: UINavigationController?
    var onExit: (() -> Void)?

    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }

    func start() {
        let controller = MainScreenAssembly().assemble(output: self)
        // Делаем главный экран корневым, чтобы не было возврата к регистрации
        navigationController?.setViewControllers([controller], animated: true)
    }
}

extension MainScreenCoordinator: MainScreenPresenterOutput {
    func exitButtonPressed() {
        onExit?()
    }
}

extension MainScreenCoordinator: MainPresenterOutput {
    func detailButtonPressed() {
        let presenter = DetailScreenPresenter(output: self)
        let controller = DetailScreenViewController(presenter: presenter)
        presenter.view = controller
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func moveToMenuViewController() {
        let presenter = MenuScreenPresenter(output: self)
        let controller = MenuScreenViewController(presenter: presenter)
        presenter.view = controller
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func moveToUserViewController() {
        let presenter = UserScreenPresenter(output: self)
        let controller = UserScreenViewController(presenter: presenter)
        presenter.view = controller
        navigationController?.present(controller, animated: true)
    }
    
    func moveToInclineViewController() {
        let presenter = InclineScreenPresenter(output: self)
        let controller = InclineScreenViewController(presenter: presenter)
        presenter.view = controller
        navigationController?.present(controller, animated: true)
    }
    
    func moveToExpensesViewController() {
        let presenter = ExpensesScreenPresenter(output: self)
        let controller = ExpensesScreenViewController(presenter: presenter)
        presenter.view = controller
        navigationController?.present(controller, animated: true)
    }
}

extension MainScreenCoordinator: DetailScreenPresenterOutput {
    func detailScreenBackButtonPressed() {
        navigationController?.popViewController(animated: true)
    }
}

extension MainScreenCoordinator: MenuScreenPresenterOutput {
    func menuScreenBackButtonPressed() {
        navigationController?.popViewController(animated: true)
    }
}

extension MainScreenCoordinator: UserScreenPresenterOutput {
    func userScreenBackButtonPressed() {
        navigationController?.popViewController(animated: true)
    }
}

extension MainScreenCoordinator: InclineScreenPresenterOutput {
    func inclineScreenBackButtonPressed() {
        navigationController?.popViewController(animated: true)
    }
}

extension MainScreenCoordinator: ExpensesScreenPresenterOutput {
    func expensesScreenBackButtonPressed() {
        navigationController?.popViewController(animated: true)
    }
}

