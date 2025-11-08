//
//  RegisterViewController.swift
//  NotificationProject
//
//  Created by Георгий Евсеев on 31.03.24.
//

import UIKit
import SnapKit

protocol IRegistrationScreenController: AnyObject {
    func showLoading()
    func hideLoading()
    func showError(_ message: String)
    func showSuccess(_ message: String)
    func enableSubmitButton(_ isEnabled: Bool)
    func clearForm()
    func setEmail(_ email: String)
    func setPassword(_ password: String)
    func navigateToMainScreen()
    func getEmail() -> String
    func getPassword() -> String
}


final class RegistrationScreenController: UIViewController {
    private let presenter: IRegistrationScreenPresenter

    private let mainLabel = UILabel()
    private let loginField = UITextField()
    private let emailField = UITextField()
    private let passwordField = UITextField()
    private let passwordStrengthView = UIProgressView(progressViewStyle: .bar)
    private let passwordStrengthLabel = UILabel()
    private let enterButton = UIButton(configuration: .filled())
    private let loginButton = UIButton(configuration: .tinted()) // 🔹 Новая кнопка
    private let returnToOnboardingButton = UIButton(configuration: .tinted())
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    private let errorLabel = UILabel()
    private let successLabel = UILabel()

    init(presenter: IRegistrationScreenPresenter) {
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

        // Заголовок
        mainLabel.text = "REGISTRATION"
        mainLabel.font = .systemFont(ofSize: 28, weight: .bold)
        mainLabel.textAlignment = .center
        view.addSubview(mainLabel)
        mainLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(40)
            $0.centerX.equalToSuperview()
        }

        // Поля
        configureTextField(loginField, placeholder: "Username", returnKeyType: .next)
        configureTextField(emailField, placeholder: "Email", keyboardType: .emailAddress, returnKeyType: .next)
        configureTextField(passwordField, placeholder: "Password", isSecure: true, returnKeyType: .done)

        let fields = UIStackView(arrangedSubviews: [loginField, emailField, passwordField])
        fields.axis = .vertical
        fields.spacing = 16
        view.addSubview(fields)
        fields.snp.makeConstraints {
            $0.top.equalTo(mainLabel.snp.bottom).offset(30)
            $0.leading.trailing.equalToSuperview().inset(40)
        }

        // Индикатор силы пароля
        passwordStrengthView.progressTintColor = .systemGreen
        passwordStrengthView.trackTintColor = .systemGray5
        passwordStrengthLabel.font = .systemFont(ofSize: 12)
        passwordStrengthLabel.textAlignment = .right
        let strengthStack = UIStackView(arrangedSubviews: [passwordStrengthView, passwordStrengthLabel])
        strengthStack.axis = .vertical
        strengthStack.spacing = 4
        view.addSubview(strengthStack)
        strengthStack.snp.makeConstraints {
            $0.top.equalTo(fields.snp.bottom).offset(8)
            $0.leading.trailing.equalTo(fields)
        }

        // Кнопка регистрации
        enterButton.configuration?.title = "Enter"
        enterButton.configuration?.baseBackgroundColor = .systemBlue
        enterButton.configuration?.cornerStyle = .large
        enterButton.addAction(UIAction { [weak self] _ in
            self?.presenter.buttonPressed()
        }, for: .touchUpInside)
        view.addSubview(enterButton)
        enterButton.snp.makeConstraints {
            $0.top.equalTo(strengthStack.snp.bottom).offset(20)
            $0.leading.trailing.equalTo(fields)
            $0.height.equalTo(50)
        }

        // 🔹 Кнопка "Уже есть аккаунт? Войти"
        loginButton.configuration?.title = "Уже есть аккаунт? Войти"
        loginButton.addAction(UIAction { [weak self] _ in
            self?.presenter.didTapLogin()
        }, for: .touchUpInside)
        view.addSubview(loginButton)
        loginButton.snp.makeConstraints {
            $0.top.equalTo(enterButton.snp.bottom).offset(12)
            $0.centerX.equalToSuperview()
        }

        // Кнопка возврата к онбордингу
        returnToOnboardingButton.configuration?.title = "Назад к онбордингу"
        returnToOnboardingButton.addAction(UIAction { [weak self] _ in
            self?.presenter.didTapReturnToOnboarding()
        }, for: .touchUpInside)
        view.addSubview(returnToOnboardingButton)
        returnToOnboardingButton.snp.makeConstraints {
            $0.top.equalTo(loginButton.snp.bottom).offset(12)
            $0.centerX.equalToSuperview()
        }

        // Индикатор загрузки
        activityIndicator.hidesWhenStopped = true
        view.addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints {
            $0.top.equalTo(returnToOnboardingButton.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
        }

        // Лейблы ошибок/успеха
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
extension RegistrationScreenController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case loginField:
            emailField.becomeFirstResponder()
        case emailField:
            passwordField.becomeFirstResponder()
        default:
            textField.resignFirstResponder()
            presenter.buttonPressed()
        }
        return true
    }
}

// MARK: - IRegistrationScreenController
extension RegistrationScreenController: IRegistrationScreenController {
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
    func enableSubmitButton(_ isEnabled: Bool) {
        enterButton.isEnabled = isEnabled
        enterButton.alpha = isEnabled ? 1.0 : 0.5
    }
    func clearForm() {
        loginField.text = ""
        emailField.text = ""
        passwordField.text = ""
        passwordStrengthView.setProgress(0, animated: false)
        passwordStrengthLabel.text = ""
    }
    func setEmail(_ email: String) { emailField.text = email }
    func setPassword(_ password: String) { passwordField.text = password }
    func navigateToMainScreen() { /* переход в главный экран */ }
    func getEmail() -> String { emailField.text ?? "" }
    func getPassword() -> String { passwordField.text ?? "" }
}


//import UIKit
//import SnapKit
//
//private extension CGFloat {
//    static let height: CGFloat = 44
//    static let mainLabelHeight: CGFloat = 50
//    static let cornerRadius: CGFloat = 30
//    static let darkAlpha: CGFloat = 0.4
//    static let font: CGFloat = 24
//    static let inset: CGFloat = 40
//    static let offset: CGFloat = 150
//    static let elementHeight: CGFloat = 50
//    static let buttonWidth: CGFloat = 90
//    static let defaultOffset: CGFloat = 20
//}
//
//private extension String {
//    static let mainLabelText = "REGISTRATION"
//    static let enterButtonText = "Enter"
//    static let accountLabelText = "Do you have an account?"
//}
//
//protocol IRegistrationScreenController: AnyObject {
//    func showLoading()
//    func hideLoading()
//    func showError(_ message: String)
//    func showSuccess(_ message: String)
//    func enableSubmitButton(_ isEnabled: Bool)
//    func clearForm()
//    func setEmail(_ email: String)
//    func setPassword(_ password: String)
//    func navigateToMainScreen()
//}
//
//final class RegistrationScreenController: UIViewController {
//    // MARK: - UI Elements
//    private let imageView = UIImageView()
//    private let mainLabel = UILabel()
//    private let loginTextView = UITextView()
//    private let emailTextView = UITextView()
//    private let passwordTextView = UITextView()
//    private let accountLabel = UILabel()
//    private let enterButton = UIButton()
//    private let activityIndicator = UIActivityIndicatorView(style: .large)
//    private let errorLabel = UILabel()
//    private let successLabel = UILabel()
//    private let returnToOnboardingButton = UIButton(configuration: .filled())
//
//
//    private let presenter: IRegistrationScreenPresenter
//
//    init(presenter: IRegistrationScreenPresenter) {
//        self.presenter = presenter
//        super.init(nibName: nil, bundle: nil)
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupUI()
//    }
//
//    private func setupUI() {
//        view.backgroundColor = .darkGray
//
//        imageView.backgroundColor = .lightGray
//        view.addSubview(imageView)
//        imageView.snp.makeConstraints { $0.edges.equalToSuperview() }
//
//        mainLabel.textAlignment = .center
//        mainLabel.text = .mainLabelText
//        view.addSubview(mainLabel)
//        mainLabel.snp.makeConstraints {
//            $0.height.equalTo(CGFloat.mainLabelHeight)
//            $0.width.equalToSuperview().inset(CGFloat.inset)
//            $0.top.equalTo(imageView.snp.top).offset(CGFloat.offset)
//            $0.centerX.equalToSuperview()
//        }
//
//        let textViews = [loginTextView, emailTextView, passwordTextView]
//        for (index, textView) in textViews.enumerated() {
//            textView.backgroundColor = .white
//            view.addSubview(textView)
//            textView.snp.makeConstraints {
//                $0.height.equalTo(CGFloat.elementHeight)
//                $0.width.equalToSuperview().inset(CGFloat.inset)
//                $0.centerX.equalToSuperview()
//                if index == 0 {
//                    $0.top.equalTo(mainLabel.snp.bottom).offset(CGFloat.defaultOffset)
//                } else {
//                    $0.top.equalTo(textViews[index - 1].snp.bottom).offset(CGFloat.defaultOffset)
//                }
//            }
//        }
//
//        accountLabel.textAlignment = .center
//        accountLabel.textColor = .blue
//        accountLabel.text = .accountLabelText
//        view.addSubview(accountLabel)
//        accountLabel.snp.makeConstraints {
//            $0.height.equalTo(CGFloat.elementHeight)
//            $0.width.equalToSuperview().inset(CGFloat.inset)
//            $0.top.equalTo(passwordTextView.snp.bottom).offset(CGFloat.defaultOffset)
//            $0.centerX.equalToSuperview()
//        }
//
//        enterButton.setTitle(.enterButtonText, for: .normal)
//        enterButton.backgroundColor = .red
//        let actionEnterButton = UIAction { [weak self] _ in
//            self?.presenter.buttonPressed()
//        }
//        enterButton.addAction(actionEnterButton, for: .touchUpInside)
//        view.addSubview(enterButton)
//        enterButton.snp.makeConstraints {
//            $0.height.equalTo(CGFloat.height)
//            $0.width.equalTo(CGFloat.buttonWidth)
//            $0.top.equalTo(accountLabel.snp.bottom).offset(CGFloat.defaultOffset)
//            $0.centerX.equalToSuperview()
//        }
//
//        activityIndicator.hidesWhenStopped = true
//        view.addSubview(activityIndicator)
//        activityIndicator.snp.makeConstraints {
//            $0.centerX.equalToSuperview()
//            $0.top.equalTo(enterButton.snp.bottom).offset(20)
//        }
//
//        errorLabel.textColor = .systemRed
//        errorLabel.textAlignment = .center
//        errorLabel.isHidden = true
//        view.addSubview(errorLabel)
//        errorLabel.snp.makeConstraints {
//            $0.top.equalTo(activityIndicator.snp.bottom).offset(10)
//            $0.centerX.equalToSuperview()
//        }
//
//        successLabel.textColor = .systemGreen
//        successLabel.textAlignment = .center
//        successLabel.isHidden = true
//        view.addSubview(successLabel)
//        successLabel.snp.makeConstraints {
//            $0.top.equalTo(errorLabel.snp.bottom).offset(10)
//            $0.centerX.equalToSuperview()
//        }
//        
//        returnToOnboardingButton.configuration?.title = "Назад к онбордингу"
//        returnToOnboardingButton.configuration?.baseBackgroundColor = .systemGray
//        returnToOnboardingButton.configuration?.baseForegroundColor = .white
//        returnToOnboardingButton.configuration?.cornerStyle = .medium
//        returnToOnboardingButton.titleLabel?.font = .preferredFont(forTextStyle: .body)
//        returnToOnboardingButton.layer.cornerRadius = 12
//        returnToOnboardingButton.clipsToBounds = true
//        returnToOnboardingButton.addTarget(self, action: #selector(didTapReturnToOnboarding), for: .touchUpInside)
//
//        view.addSubview(returnToOnboardingButton)
//        returnToOnboardingButton.snp.makeConstraints {
//            $0.height.equalTo(CGFloat.height)
//            $0.width.equalToSuperview().inset(CGFloat.inset)
//            $0.top.equalTo(successLabel.snp.bottom).offset(CGFloat.defaultOffset * 2)
//            $0.centerX.equalToSuperview()
//        }
//
//    }
//}
//
//// MARK: - IRegistrationScreenController
//extension RegistrationScreenController: IRegistrationScreenController {
//    func showLoading() {
//        activityIndicator.startAnimating()
//    }
//
//    func hideLoading() {
//        activityIndicator.stopAnimating()
//    }
//
//    func showError(_ message: String) {
//        errorLabel.text = message
//        errorLabel.isHidden = false
//        successLabel.isHidden = true
//    }
//
//    func showSuccess(_ message: String) {
//        successLabel.text = message
//        successLabel.isHidden = false
//        errorLabel.isHidden = true
//    }
//
//    func enableSubmitButton(_ isEnabled: Bool) {
//        enterButton.isEnabled = isEnabled
//    }
//
//    func clearForm() {
//        loginTextView.text = ""
//        emailTextView.text = ""
//        passwordTextView.text = ""
//    }
//
//    func setEmail(_ email: String) {
//        emailTextView.text = email
//    }
//
//    func setPassword(_ password: String) {
//        passwordTextView.text = password
//    }
//
//    func navigateToMainScreen() {
//        presenter.buttonPressed()
//    }
//    
//    @objc private func didTapReturnToOnboarding() {
//        presenter.didTapReturnToOnboarding()
//    }
//
//}



