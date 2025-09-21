//
//  OnboardingCoordinator.swift
//  NotificationProject
//
//  Created by Георгий Евсеев on 21.09.25.
//

import Foundation

import UIKit

final class OnboardingCoordinator: NSObject {
    private weak var navigationController: UINavigationController?
    var onFinish: (() -> Void)?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let onboardingVC = OnboardingViewController()
        onboardingVC.delegate = self
        navigationController?.setViewControllers([onboardingVC], animated: true)
    }
}

extension OnboardingCoordinator: OnboardingViewControllerDelegate {
    func onboardingDidFinish() {
        onFinish?()
        print("Делегат сработал")
    }
}


