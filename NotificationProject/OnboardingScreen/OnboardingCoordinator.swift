//
//  OnboardingCoordinator.swift
//  NotificationProject
//
//  Created by Георгий Евсеев on 21.09.25.
//

import Foundation

import UIKit

final class OnboardingCoordinator {
    private weak var navigationController: UINavigationController?
    var onFinish: (() -> Void)?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let controller = OnboardingAssembly().assemble(output: self)
        navigationController?.setViewControllers([controller], animated: true)
    }
}

extension OnboardingCoordinator: OnboardingPresenterOutput {
    func onboardingDidFinish() {
        onFinish?()
        print("Делегат сработал")
    }
}



