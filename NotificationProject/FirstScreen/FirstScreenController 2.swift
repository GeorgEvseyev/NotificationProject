//
//  FirstScreenController.swift
//  NotificationProject
//
//  Created by Георгий Евсеев on 13.04.24.
//

import UIKit

protocol IFirstScreenController: AnyObject {
    func setLabelText(_ text: String)
}

final class FirstScreenController: UIViewController {

    private let nextButton = {
        let button = UIButton()
        button.setTitle("Next", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let label = {
        let label = UILabel()
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let presenter: IFirstScreenPresenter

    init(presenter: IFirstScreenPresenter) {
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
        view.backgroundColor = .white

        view.addSubview(nextButton)
        let action = UIAction { _ in
            self.buttonPressed()
        }
        nextButton.addAction(action, for: .touchUpInside)

        nextButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24).isActive = true
        nextButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -64).isActive = true
        nextButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        nextButton.widthAnchor.constraint(equalToConstant: 100).isActive = true

        view.addSubview(label)
        label.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24).isActive = true
        label.topAnchor.constraint(equalTo: view.topAnchor, constant: 64).isActive = true
        label.heightAnchor.constraint(equalToConstant: 50).isActive = true
        label.widthAnchor.constraint(equalToConstant: 200).isActive = true
    }

    func buttonPressed() {
        presenter.buttonPressed()
    }
}

extension FirstScreenController: IFirstScreenController {
    func setLabelText(_ text: String) {
        label.text = text
    }
}
