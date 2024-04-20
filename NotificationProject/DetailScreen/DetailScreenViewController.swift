//
//  DetailViewController.swift
//  NotificationProject
//
//  Created by Георгий Евсеев on 15.04.24.
//

import UIKit


protocol IDetailScreenController: AnyObject {
    func setLabelText(_ text: String)
}

final class DetailScreenViewController: UIViewController {
    
    let bottomPartofView: UIView = {
        let bottomPartofView = UIView()
        bottomPartofView.backgroundColor = .opaqueSeparator
        return bottomPartofView
    }()

    let textField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        return textField
    }()

    let textView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .white
        return textView
    }()

    let picker: UIPickerView = {
        let picker = UIPickerView()
        picker.backgroundColor = .brown
        return picker
    }()
    
    private let presenter: IDetailScreenPresenter

    init(presenter: IDetailScreenPresenter) {
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
    
    func setupUI() {
        view.backgroundColor = .gray
        
        view.addSubview(bottomPartofView)
        bottomPartofView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.height.equalToSuperview().dividedBy(3)
        }
        let tapRecognizer: UITapGestureRecognizer = {
            let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(moveFirstScreenController))
            return tapRecognizer
        }()
        bottomPartofView.addGestureRecognizer(tapRecognizer)
        
        view.addSubview(textField)
        textField.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(Offsets.defaultOffset)
            make.height.equalTo(44)
            make.bottom.equalTo(bottomPartofView.snp.top)
        }
        
        view.addSubview(textView)
        textView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(Offsets.defaultOffset)
            make.right.equalToSuperview().inset(Offsets.defaultOffset)
            make.height.equalToSuperview().dividedBy(3)
            make.bottom.equalTo(textField.snp.top)
        }
        
        view.addSubview(picker)
        picker.snp.makeConstraints { make in
            make.left.equalTo(textField.snp.right).offset(Offsets.defaultOffset)
            make.right.equalToSuperview().inset(Insets.defaultInset)
            make.width.equalTo(textView.snp.width).dividedBy(3)
            make.bottom.equalTo(textField.snp.bottom)
            make.height.equalTo(textField.snp.height)
        }
    }


    @objc func moveFirstScreenController() {
        navigationController?.popViewController(animated: true)
    }
}

extension DetailScreenViewController: IDetailScreenController {
    func setLabelText(_ text: String) {

    }
}
