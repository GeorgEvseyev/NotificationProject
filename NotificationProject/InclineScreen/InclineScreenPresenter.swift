//
//  SecondPresenter.swift
//  DI
//
//  Created by Igor Lebedev on 31.03.24.
//

import Foundation

protocol IInclineScreenPresenter {
    func buttonPressed()
}

final class InclineScreenPresenter: IInclineScreenPresenter {

    private let output: InclineScreenPresenterOutput
    weak var view: IInclineScreenViewController?

    init(output: InclineScreenPresenterOutput) {
        self.output = output
    }

    func buttonPressed() {
        view?.setLabelText("Going back")

        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.output.inclineScreenBackButtonPressed()
        }
    }
}
