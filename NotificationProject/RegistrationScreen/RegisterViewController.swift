//
//  RegisterViewController.swift
//  NotificationProject
//
//  Created by Георгий Евсеев on 31.03.24.
//

import Foundation
import UIKit
import SnapKit

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
        label.text = "REGISTRATION"
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
        label.text = "Do you have an account?"
        return label
    }()
    
    let enterButton: UIButton = {
        let button = UIButton()
        button.setTitle("Enter", for: .normal)
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
            make.height.equalTo(50)
            make.width.equalToSuperview().inset(40)
            make.top.equalTo(imageView.snp.top).offset(150)
            make.centerX.equalTo(imageView.snp.centerX)
        }
        
        view.addSubview(loginTextView)
        loginTextView.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.width.equalToSuperview().inset(40)
            make.top.equalTo(mainLabel.snp.bottom).offset(Offsets.defaultOffset)
            make.centerX.equalTo(imageView.snp.centerX)
        }
        
        view.addSubview(emailTextView)
        emailTextView.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.width.equalToSuperview().inset(40)
            make.top.equalTo(loginTextView.snp.bottom).offset(Offsets.defaultOffset)
            make.centerX.equalTo(imageView.snp.centerX)
        }
        
        view.addSubview(passwordTextView)
        passwordTextView.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.width.equalToSuperview().inset(40)
            make.top.equalTo(emailTextView.snp.bottom).offset(Offsets.defaultOffset)
            make.centerX.equalTo(imageView.snp.centerX)
        }
        
        view.addSubview(accountlabel)
        accountlabel.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.width.equalToSuperview().inset(40)
            make.top.equalTo(passwordTextView.snp.bottom).offset(Offsets.defaultOffset)
            make.centerX.equalTo(imageView.snp.centerX)
        }
        
        view.addSubview(enterButton)
        let actionEnterButton = UIAction { _ in
            self.presenter.buttonPressed()
        }
        enterButton.addAction(actionEnterButton, for: .touchUpInside)
        enterButton.snp.makeConstraints { make in
            make.height.equalTo(44)
            make.width.equalTo(90)
            make.top.equalTo(accountlabel.snp.bottom).offset(Offsets.defaultOffset)
            make.centerX.equalTo(imageView.snp.centerX)
        }
    }
//    
//    
//    func showViewController() {
//        let vc = MainScreenController()
//        navigationController?.pushViewController(vc, animated: true)
//    }
}

extension RegistrationScreenController: IRegistrationScreenController {
    func setLabelText(_ text: String) {

    }
}
