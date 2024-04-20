//
//  SecondPresenter.swift
//  DI
//
//  Created by Igor Lebedev on 31.03.24.
//

import Foundation

protocol IMenuScreenPresenter {
    func buttonPressed()
}

final class MenuScreenPresenter: IMenuScreenPresenter {

    private let output: MenuScreenPresenterOutput
    weak var view: IMenuScreenController?

    init(output: MenuScreenPresenterOutput) {
        self.output = output
    }

    func buttonPressed() {
        view?.setLabelText("Going back")

        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.output.menuScreenBackButtonPressed()
        }
    }
}
