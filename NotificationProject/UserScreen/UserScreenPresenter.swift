//
//  SecondPresenter.swift
//  DI
//
//  Created by Igor Lebedev on 31.03.24.
//

import Foundation

protocol IUserScreenPresenter {
    func buttonPressed()
    func didSelectMenuItem(at index: Int)
}

final class UserScreenPresenter: IUserScreenPresenter {

    private let output: UserScreenPresenterOutput
    weak var view: IUserScreenController?

    init(output: UserScreenPresenterOutput) {
        self.output = output
    }

    func buttonPressed() {
        view?.setLabelText("Going back")

        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.output.userScreenBackButtonPressed()
        }
    }

    func didSelectMenuItem(at index: Int) {
        switch index {
        case 0:
            view?.setLabelText("Incline выбран")
            output.userScreenInclineSelected()
        case 1:
            view?.setLabelText("Expenses выбран")
            output.userScreenExpensesSelected()
        case 2:
            view?.setLabelText("Settings выбран")
            output.userScreenSettingsSelected()
        default:
            break
        }
    }
}

