//
//  RegisterViewController.swift
//  NotificationProject
//
//  Created by Георгий Евсеев on 31.03.24.
//

import UIKit
import SnapKit

private extension CGFloat {
    static let height: CGFloat = 44
    static let mainLabelHeight: CGFloat = 50
    static let cornerRadius: CGFloat = 30
    static let darkAlpha: CGFloat = 0.4
    static let font: CGFloat = 24
    static let inset: CGFloat = 40
    static let offset: CGFloat = 150
    static let elementHeight: CGFloat = 50
    static let buttonWidth: CGFloat = 90
    static let defaultOffset: CGFloat = 20
}

private extension String {
    static let mainLabelText = "REGISTRATION"
    static let enterButtonText = "Enter"
    static let accountLabelText = "Do you have an account?"
}

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
}

final class RegistrationScreenController: UIViewController {
    // MARK: - UI Elements
    private let imageView = UIImageView()
    private let mainLabel = UILabel()
    private let loginTextView = UITextView()
    private let emailTextView = UITextView()
    private let passwordTextView = UITextView()
    private let accountLabel = UILabel()
    private let enterButton = UIButton()
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    private let errorLabel = UILabel()
    private let successLabel = UILabel()
    private let returnToOnboardingButton = UIButton(configuration: .filled())


    private let presenter: IRegistrationScreenPresenter

    init(presenter: IRegistrationScreenPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        view.backgroundColor = .darkGray

        imageView.backgroundColor = .lightGray
        view.addSubview(imageView)
        imageView.snp.makeConstraints { $0.edges.equalToSuperview() }

        mainLabel.textAlignment = .center
        mainLabel.text = .mainLabelText
        view.addSubview(mainLabel)
        mainLabel.snp.makeConstraints {
            $0.height.equalTo(CGFloat.mainLabelHeight)
            $0.width.equalToSuperview().inset(CGFloat.inset)
            $0.top.equalTo(imageView.snp.top).offset(CGFloat.offset)
            $0.centerX.equalToSuperview()
        }

        let textViews = [loginTextView, emailTextView, passwordTextView]
        for (index, textView) in textViews.enumerated() {
            textView.backgroundColor = .white
            view.addSubview(textView)
            textView.snp.makeConstraints {
                $0.height.equalTo(CGFloat.elementHeight)
                $0.width.equalToSuperview().inset(CGFloat.inset)
                $0.centerX.equalToSuperview()
                if index == 0 {
                    $0.top.equalTo(mainLabel.snp.bottom).offset(CGFloat.defaultOffset)
                } else {
                    $0.top.equalTo(textViews[index - 1].snp.bottom).offset(CGFloat.defaultOffset)
                }
            }
        }

        accountLabel.textAlignment = .center
        accountLabel.textColor = .blue
        accountLabel.text = .accountLabelText
        view.addSubview(accountLabel)
        accountLabel.snp.makeConstraints {
            $0.height.equalTo(CGFloat.elementHeight)
            $0.width.equalToSuperview().inset(CGFloat.inset)
            $0.top.equalTo(passwordTextView.snp.bottom).offset(CGFloat.defaultOffset)
            $0.centerX.equalToSuperview()
        }

        enterButton.setTitle(.enterButtonText, for: .normal)
        enterButton.backgroundColor = .red
        let actionEnterButton = UIAction { [weak self] _ in
            self?.presenter.buttonPressed()
        }
        enterButton.addAction(actionEnterButton, for: .touchUpInside)
        view.addSubview(enterButton)
        enterButton.snp.makeConstraints {
            $0.height.equalTo(CGFloat.height)
            $0.width.equalTo(CGFloat.buttonWidth)
            $0.top.equalTo(accountLabel.snp.bottom).offset(CGFloat.defaultOffset)
            $0.centerX.equalToSuperview()
        }

        activityIndicator.hidesWhenStopped = true
        view.addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(enterButton.snp.bottom).offset(20)
        }

        errorLabel.textColor = .systemRed
        errorLabel.textAlignment = .center
        errorLabel.isHidden = true
        view.addSubview(errorLabel)
        errorLabel.snp.makeConstraints {
            $0.top.equalTo(activityIndicator.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
        }

        successLabel.textColor = .systemGreen
        successLabel.textAlignment = .center
        successLabel.isHidden = true
        view.addSubview(successLabel)
        successLabel.snp.makeConstraints {
            $0.top.equalTo(errorLabel.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
        }
        
        returnToOnboardingButton.configuration?.title = "Назад к онбордингу"
        returnToOnboardingButton.configuration?.baseBackgroundColor = .systemGray
        returnToOnboardingButton.configuration?.baseForegroundColor = .white
        returnToOnboardingButton.configuration?.cornerStyle = .medium
        returnToOnboardingButton.titleLabel?.font = .preferredFont(forTextStyle: .body)
        returnToOnboardingButton.layer.cornerRadius = 12
        returnToOnboardingButton.clipsToBounds = true
        returnToOnboardingButton.addTarget(self, action: #selector(didTapReturnToOnboarding), for: .touchUpInside)

        view.addSubview(returnToOnboardingButton)
        returnToOnboardingButton.snp.makeConstraints {
            $0.height.equalTo(CGFloat.height)
            $0.width.equalToSuperview().inset(CGFloat.inset)
            $0.top.equalTo(successLabel.snp.bottom).offset(CGFloat.defaultOffset * 2)
            $0.centerX.equalToSuperview()
        }

    }
}

// MARK: - IRegistrationScreenController
extension RegistrationScreenController: IRegistrationScreenController {
    func showLoading() {
        activityIndicator.startAnimating()
    }

    func hideLoading() {
        activityIndicator.stopAnimating()
    }

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
    }

    func clearForm() {
        loginTextView.text = ""
        emailTextView.text = ""
        passwordTextView.text = ""
    }

    func setEmail(_ email: String) {
        emailTextView.text = email
    }

    func setPassword(_ password: String) {
        passwordTextView.text = password
    }

    func navigateToMainScreen() {
        presenter.buttonPressed()
    }
    
    @objc private func didTapReturnToOnboarding() {
        presenter.didTapReturnToOnboarding()
    }

}



