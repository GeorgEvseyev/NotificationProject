//
//  SecondPresenter.swift
//  DI
//
//  Created by Igor Lebedev on 31.03.24.
//

//import Foundation
//import FirebaseAuth
//
//protocol IRegistrationScreenPresenter {
//    func buttonPressed()
//    func didTapReturnToOnboarding()
//}



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

import FirebaseAuth

protocol IRegistrationScreenPresenter {
    func buttonPressed()
    func didTapReturnToOnboarding()
    func didTapLogin()
}

final class RegistrationScreenPresenter: IRegistrationScreenPresenter {
    weak var view: IRegistrationScreenController?
    private weak var output: RegistrationScreenPresenterOutput?

    init(output: RegistrationScreenPresenterOutput) {
        self.output = output
    }

    func buttonPressed() {
        print("Кнопка нажата")
        let email = view?.getEmail() ?? ""
        let password = view?.getPassword() ?? ""
        print("Email: \(email), Password: \(password)")
        
        guard !email.isEmpty, !password.isEmpty else {
            view?.showError("Заполните все поля")
            return
        }

        view?.showLoading()

        Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
            guard let self = self else { return }
            self.view?.hideLoading()

            if let error = error {
                self.view?.showError(error.localizedDescription)
                print("Firebase error: \(error)")
                return
            }

            self.view?.showSuccess("Регистрация успешна!")
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.output?.registrationDidFinish()
            }
        }
    }

    func didTapReturnToOnboarding() {
        output?.returnToOnboardingRequested()
    }
    
    func didTapLogin() {
        output?.loginRequested()
    }
}





