//
//  FirstScreenPresenter.swift
//  NotificationProject
//
//  Created by Георгий Евсеев on 13.04.24.
//

import Foundation

protocol IFirstScreenPresenter {
    func buttonPressed()
}

final class FirstScreenPresenter: IFirstScreenPresenter {

    private let output: FirstScreenPresenterOutput
    private let storageService: IStorageService
    weak var view: IFirstScreenController?

    init(
        output: FirstScreenPresenterOutput,
        storageService: IStorageService
    ) {
        self.output = output
        self.storageService = storageService
    }

    func buttonPressed() {
        view?.setLabelText("Prepare to navigate")

        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.output.navigationButtonPressed()
        }
    }
}
