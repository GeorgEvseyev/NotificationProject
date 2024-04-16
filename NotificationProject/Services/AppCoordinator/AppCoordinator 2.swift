//
//  AppCoordinator.swift
//  DI
//
//  Created by Igor Lebedev on 31.03.24.
//

import UIKit

final class AppCoordinator {

    func start(in window: UIWindow) {
        let coordinator = FirstScreenCoordinator()
        coordinator.start(in: window)
    }
}
