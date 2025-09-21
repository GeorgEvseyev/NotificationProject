//
//  OnboardingAssembly.swift
//  NotificationProject
//
//  Created by Георгий Евсеев on 21.09.25.
//

import Foundation
import UIKit

final class OnboardingAssembly {
    func assemble(output: OnboardingPresenterOutput) -> UIViewController {
        let presenter = OnboardingPresenter(output: output)
        let controller = OnboardingViewController(presenter: presenter)
        presenter.attachView(controller)
        return controller
    }
}

