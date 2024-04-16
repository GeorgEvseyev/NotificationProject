//
//  AppCoordinator.swift
//  NotificationProject
//
//  Created by Георгий Евсеев on 13.04.24.
//


import UIKit

final class AppCoordinator {

    func start(in window: UIWindow) {
        let coordinator = FirstScreenCoordinator()
        coordinator.start(in: window)
    }
}
