//
//  SecondPresenter.swift
//  DI
//
//  Created by Igor Lebedev on 31.03.24.
//

import Foundation

protocol IExpensesScreenPresenter {
    func buttonPressed()
}

final class ExpensesScreenPresenter: IExpensesScreenPresenter {

    private let output: ExpensesScreenPresenterOutput
    weak var view: IExpensesScreenController?

    init(output: ExpensesScreenPresenterOutput) {
        self.output = output
    }

    func buttonPressed() {
        view?.setLabelText("Going back")

        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.output.expensesScreenBackButtonPressed()
        }
    }
}
