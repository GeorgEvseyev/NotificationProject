//
//  SecondPresenter.swift
//  DI
//
//  Created by Igor Lebedev on 31.03.24.
//

import Foundation

protocol IUserScreenPresenter {
    func buttonPressed()
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
}
