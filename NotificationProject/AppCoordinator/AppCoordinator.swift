//
//  AppCoordinator.swift
//  NotificationProject
//
//  Created by Георгий Евсеев on 13.04.24.
//


import UIKit
//
//final class AppCoordinator {
//
//    func start(in window: UIWindow) {
//        let coordinator = RegistrationScreenCoordinator()
//        coordinator.start(in: window)
//    }
//}

final class AppCoordinator {
    private let window: UIWindow
    private let navigationController: UINavigationController
    private var onboardingCoordinator: OnboardingCoordinator?
    private var registrationCoordinator: RegistrationScreenCoordinator?
    private var mainCoordinator: MainScreenCoordinator?

    init(window: UIWindow) {
        self.window = window
        self.navigationController = UINavigationController()
        self.navigationController.setNavigationBarHidden(true, animated: false)
        self.window.rootViewController = navigationController
        self.window.makeKeyAndVisible()
    }

    func start() {
        if !UserDefaults.standard.bool(forKey: "hasSeenOnboarding") {
            showOnboarding()
        } else {
            showRegistration()
        }
    }

    private func showOnboarding() {
        onboardingCoordinator = OnboardingCoordinator(navigationController: navigationController)
        onboardingCoordinator?.onFinish = { [weak self] in
            UserDefaults.standard.set(true, forKey: "hasSeenOnboarding")
            self?.showRegistration()
        }
        onboardingCoordinator?.start()
    }

    private func showRegistration() {
        registrationCoordinator = RegistrationScreenCoordinator(
            navigationController: navigationController,
            appCoordinator: self
        )
        registrationCoordinator?.onEnter = { [weak self] in
            self?.showMainScreen()
        }
        registrationCoordinator?.start()
    }

    func restartOnboardingFlow() {
        showOnboarding()
    }

    private func showMainScreen() {
        mainCoordinator = MainScreenCoordinator(navigationController: navigationController)
        mainCoordinator?.start()
    }
}



