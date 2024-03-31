//
//  RegisterViewController.swift
//  NotificationProject
//
//  Created by Георгий Евсеев on 31.03.24.
//

import Foundation
import UIKit

final class RegisterViewController: UIViewController {
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .white
        return imageView
    }()

    let mainLabel: UILabel = {
        let label = UILabel()
        label.text = "Registration"
        return label
    }()
    
    let loginTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .lightGray
        return textView
    }()
    
    let emailTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .lightGray
        return textView
    }()
    
    let passwordTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .lightGray
        return textView
    }()
    
    let accountlabel: UILabel = {
        let label = UILabel()
        label.text = "Do you have an account?"
        return label
    }()
    
    let enterButton: UIButton = {
        let button = UIButton()
        button.setTitle("Enter", for: .normal)
        return button
    }()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .darkGray
        view.addSubview(imageView)
        imageView.addSubview(mainLabel)
        imageView.addSubview(loginTextView)
        imageView.addSubview(emailTextView)
        imageView.addSubview(passwordTextView)
        imageView.addSubview(accountlabel)
        imageView.addSubview(enterButton)
        
        makeConstraints()
        setupButton()
    }
    
    func makeConstraints() {
        imageView.snp.makeConstraints { make in
            make.height.width.top.bottom.right.left.equalToSuperview()
        }
        
        mainLabel.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.width.equalToSuperview().offset(40)
            make.top.equalTo(imageView.snp.top).offset(Offsets.defaultOffset)
            make.centerX.equalTo(imageView.snp.centerX)
        }
        
        loginTextView.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.width.equalToSuperview().offset(40)
            make.top.equalTo(mainLabel.snp.bottom).offset(Offsets.defaultOffset)
            make.centerX.equalTo(imageView.snp.centerX)
        }
        
        emailTextView.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.width.equalToSuperview().offset(40)
            make.top.equalTo(loginTextView.snp.bottom).offset(Offsets.defaultOffset)
            make.centerX.equalTo(imageView.snp.centerX)
        }
        
        passwordTextView.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.width.equalToSuperview().offset(40)
            make.top.equalTo(emailTextView.snp.bottom).offset(Offsets.defaultOffset)
            make.centerX.equalTo(imageView.snp.centerX)
        }
        
        accountlabel.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.width.equalToSuperview().offset(40)
            make.top.equalTo(passwordTextView.snp.bottom).offset(Offsets.defaultOffset)
            make.centerX.equalTo(imageView.snp.centerX)
        }
        
        enterButton.snp.makeConstraints { make in
            make.height.equalTo(44)
            make.width.equalTo(90)
            make.top.equalTo(accountlabel.snp.bottom).offset(Offsets.defaultOffset)
            make.centerX.equalTo(imageView.snp.centerX)
        }
    }
    
    func showViewController() {
        let vc = ViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func setupButton() {
        let action = UIAction { _ in
            self.showViewController()
        }
        enterButton.addAction(action, for: .touchUpInside)
    }
}
