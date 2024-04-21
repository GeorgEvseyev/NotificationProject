//
//  RegisterViewController.swift
//  NotificationProject
//
//  Created by Георгий Евсеев on 31.03.24.
//

import Foundation
import SnapKit
import UIKit

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
    static let mainLabelText: String = "REGISTRATION"
    static let enterButtonText: String = "Enter"
    static let accountLabelText: String = "Do you have an account?"
}

protocol IRegistrationScreenController: AnyObject {
    func setLabelText(_ text: String)
}

final class RegistrationScreenController: UIViewController {
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .lightGray
        return imageView
    }()

    let mainLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = .mainLabelText
        return label
    }()

    let loginTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .white
        return textView
    }()

    let emailTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .white
        return textView
    }()

    let passwordTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .white
        return textView
    }()

    let accountlabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .blue
        label.text = .accountLabelText
        return label
    }()

    let enterButton: UIButton = {
        let button = UIButton()
        button.setTitle(.enterButtonText, for: .normal)
        button.backgroundColor = .red
        return button
    }()

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

        view.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        view.addSubview(mainLabel)
        mainLabel.snp.makeConstraints { make in
            make.height.equalTo(CGFloat.mainLabelHeight)
            make.width.equalToSuperview().inset(CGFloat.inset)
            make.top.equalTo(imageView.snp.top).offset(CGFloat.offset)
            make.centerX.equalToSuperview()
        }

        let textViews = [loginTextView, emailTextView, passwordTextView]
        for (index, textView) in textViews.enumerated() {
            view.addSubview(textView)
            textView.snp.makeConstraints { make in
                make.height.equalTo(CGFloat.elementHeight)
                make.width.equalToSuperview().inset(CGFloat.inset)
                make.centerX.equalToSuperview()
                if index == 0 {
                    make.top.equalTo(mainLabel.snp.bottom).offset(CGFloat.defaultOffset)
                } else {
                    make.top.equalTo(textViews[index - 1].snp.bottom).offset(CGFloat.defaultOffset)
                }
            }
        }

        view.addSubview(accountlabel)
        accountlabel.snp.makeConstraints { make in
            make.height.equalTo(CGFloat.elementHeight)
            make.width.equalToSuperview().inset(CGFloat.inset)
            make.top.equalTo(passwordTextView.snp.bottom).offset(CGFloat.defaultOffset)
            make.centerX.equalToSuperview()
        }

        view.addSubview(enterButton)
        let actionEnterButton = UIAction { _ in
            self.presenter.buttonPressed()
        }
        enterButton.addAction(actionEnterButton, for: .touchUpInside)
        enterButton.snp.makeConstraints { make in
            make.height.equalTo(CGFloat.height)
            make.width.equalTo(CGFloat.buttonWidth)
            make.top.equalTo(accountlabel.snp.bottom).offset(CGFloat.defaultOffset)
            make.centerX.equalToSuperview()
        }
    }
}

extension RegistrationScreenController: IRegistrationScreenController {
    func setLabelText(_ text: String) {
    }
}
