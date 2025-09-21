//
//  SecondPresenter.swift
//  DI
//
//  Created by Igor Lebedev on 31.03.24.
//

import Foundation

protocol IRegistrationScreenPresenter {
    func buttonPressed()
    func didTapReturnToOnboarding()
}



//final class RegistrationScreenPresenter: IRegistrationScreenPresenter {
//
//    private let output: RegistrationScreenPresenterOutput
//    private let storageService: IStorageService
//    weak var view: IRegistrationScreenController?
//
//    init(output: RegistrationScreenPresenterOutput, storageService: IStorageService) {
//        self.output = output
//        self.storageService = storageService
//    }
//
//    func buttonPressed() {
//        output.enterButtonPressed()
////        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
////            self.output.enterButtonPressed()
////        }
//    }
//}

final class RegistrationScreenPresenter: IRegistrationScreenPresenter {
    private let output: RegistrationScreenPresenterOutput
    private let storageService: IStorageService
    weak var view: IRegistrationScreenController?

    init(output: RegistrationScreenPresenterOutput, storageService: IStorageService) {
        self.output = output
        self.storageService = storageService
    }

    func buttonPressed() {
        output.enterButtonPressed()
    }

    func didTapReturnToOnboarding() {
        output.returnToOnboardingRequested()
    }

}

