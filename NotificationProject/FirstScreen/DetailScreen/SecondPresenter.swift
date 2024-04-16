//
//  SecondPresenter.swift
//  NotificationProject
//
//  Created by Георгий Евсеев on 13.04.24.
//

import Foundation

protocol ISecondPresenter {
    func buttonPressed()
}

final class SecondPresenter: ISecondPresenter {

    private let output: SecondPresenterOutput
    weak var view: ISecondController?

    init(output: SecondPresenterOutput) {
        self.output = output
    }

    func buttonPressed() {
        view?.setLabelText("Going back")

        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.output.backButtonPressed()
        }
    }
}
