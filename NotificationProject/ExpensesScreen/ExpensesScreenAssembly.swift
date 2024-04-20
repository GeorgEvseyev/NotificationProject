//
//  SecondScreenAssembly.swift
//  DI
//
//  Created by Igor Lebedev on 31.03.24.
//

import UIKit

final class ExpensesScreenAssembly {

    func assemble(output: ExpensesScreenPresenterOutput) -> UIViewController {

        let presenter = ExpensesScreenPresenter(output: output)
        let controller = ExpensesScreenViewController(presenter: presenter)
        presenter.view = controller

        return controller
    }

}

