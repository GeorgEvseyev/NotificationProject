//
//  LoginScreenPresenter.swift
//  NotificationProject
//
//  Created by Георгий Евсеев on 21.09.25.
//

import FirebaseAuth

protocol ILoginScreenPresenter {
    func loginButtonPressed()
    func didTapReturnToRegistration()
}

final class LoginScreenPresenter: ILoginScreenPresenter {
    weak var view: ILoginScreenController?
    private weak var output: LoginScreenPresenterOutput?

    init(output: LoginScreenPresenterOutput) {
        self.output = output
    }

    func loginButtonPressed() {
        let email = view?.getEmail() ?? ""
        let password = view?.getPassword() ?? ""

        guard !email.isEmpty, !password.isEmpty else {
            view?.showError("Заполните все поля")
            return
        }

        view?.showLoading()

        Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
            guard let self = self else { return }
            self.view?.hideLoading()

            if let error = error {
                self.view?.showError(error.localizedDescription)
                return
            }

            self.view?.showSuccess("Вход выполнен!")
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.output?.loginDidFinish()
            }
        }
    }

    func didTapReturnToRegistration() {
        output?.returnToRegistrationRequested()
    }
}
