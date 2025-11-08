//
//  LoginScreenController.swift
//  NotificationProject
//
//  Created by Георгий Евсеев on 21.09.25.
//

import Foundation

import UIKit
import SnapKit

protocol ILoginScreenController: AnyObject {
    func showLoading()
    func hideLoading()
    func showError(_ message: String)
    func showSuccess(_ message: String)
    func enableLoginButton(_ isEnabled: Bool)
    func getEmail() -> String
    func getPassword() -> String
}

final class LoginScreenController: UIViewController {
    private let presenter: ILoginScreenPresenter

    private let emailField = UITextField()
    private let passwordField = UITextField()
    private let loginButton = UIButton(configuration: .filled())
    private let returnButton = UIButton(configuration: .tinted())
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    private let errorLabel = UILabel()
    private let successLabel = UILabel()

    init(presenter: ILoginScreenPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupKeyboardDismiss()
    }

    private func setupUI() {
        view.backgroundColor = .systemBackground

        configureTextField(emailField, placeholder: "Email", keyboardType: .emailAddress, returnKeyType: .next)
        configureTextField(passwordField, placeholder: "Password", isSecure: true, returnKeyType: .done)

        let stack = UIStackView(arrangedSubviews: [emailField, passwordField])
        stack.axis = .vertical
        stack.spacing = 16
        view.addSubview(stack)
        stack.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(100)
            $0.leading.trailing.equalToSuperview().inset(40)
        }

        loginButton.configuration?.title = "Sign In"
        loginButton.configuration?.baseBackgroundColor = .systemBlue
        loginButton.configuration?.cornerStyle = .large
        loginButton.addAction(UIAction { [weak self] _ in
            self?.presenter.loginButtonPressed()
        }, for: .touchUpInside)
        view.addSubview(loginButton)
        loginButton.snp.makeConstraints {
            $0.top.equalTo(stack.snp.bottom).offset(20)
            $0.leading.trailing.equalTo(stack)
            $0.height.equalTo(50)
        }

        returnButton.configuration?.title = "Назад к регистрации"
        returnButton.addAction(UIAction { [weak self] _ in
            self?.presenter.didTapReturnToRegistration()
        }, for: .touchUpInside)
        view.addSubview(returnButton)
        returnButton.snp.makeConstraints {
            $0.top.equalTo(loginButton.snp.bottom).offset(12)
            $0.centerX.equalToSuperview()
        }

        activityIndicator.hidesWhenStopped = true
        view.addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints {
            $0.top.equalTo(returnButton.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
        }

        configureMessageLabel(errorLabel, color: .systemRed)
        configureMessageLabel(successLabel, color: .systemGreen)
        view.addSubview(errorLabel)
        view.addSubview(successLabel)
        errorLabel.snp.makeConstraints {
            $0.top.equalTo(activityIndicator.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        successLabel.snp.makeConstraints {
            $0.top.equalTo(errorLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
    }

    private func configureTextField(_ tf: UITextField,
                                    placeholder: String,
                                    keyboardType: UIKeyboardType = .default,
                                    isSecure: Bool = false,
                                    returnKeyType: UIReturnKeyType) {
        tf.placeholder = placeholder
        tf.borderStyle = .roundedRect
        tf.keyboardType = keyboardType
        tf.isSecureTextEntry = isSecure
        tf.autocapitalizationType = .none
        tf.autocorrectionType = .no
        tf.clearButtonMode = .whileEditing
        tf.returnKeyType = returnKeyType
        tf.delegate = self
    }

    private func configureMessageLabel(_ label: UILabel, color: UIColor) {
        label.textColor = color
        label.font = .systemFont(ofSize: 14)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.isHidden = true
    }

    private func setupKeyboardDismiss() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }

    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}

// MARK: - UITextFieldDelegate
extension LoginScreenController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailField {
            passwordField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
            presenter.loginButtonPressed()
        }
        return true
    }
}

// MARK: - ILoginScreenController
extension LoginScreenController: ILoginScreenController {
    func showLoading() { activityIndicator.startAnimating() }
    func hideLoading() { activityIndicator.stopAnimating() }
    func showError(_ message: String) {
        errorLabel.text = message
        errorLabel.isHidden = false
        successLabel.isHidden = true
    }
    func showSuccess(_ message: String) {
        successLabel.text = message
        successLabel.isHidden = false
        errorLabel.isHidden = true
    }
    func enableLoginButton(_ isEnabled: Bool) {
        loginButton.isEnabled = isEnabled
        loginButton.alpha = isEnabled ? 1.0 : 0.5
    }
    func getEmail() -> String { emailField.text ?? "" }
    func getPassword() -> String { passwordField.text ?? "" }
}
