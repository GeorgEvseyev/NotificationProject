//
//  LoginScreenAssembly.swift
//  NotificationProject
//
//  Created by Георгий Евсеев on 21.09.25.
//

import Foundation
import UIKit

final class LoginScreenAssembly {
    func assemble(output: LoginScreenPresenterOutput) -> UIViewController {
        let presenter = LoginScreenPresenter(output: output)
        let controller = LoginScreenController(presenter: presenter)
        presenter.view = controller
        return controller
    }
}

