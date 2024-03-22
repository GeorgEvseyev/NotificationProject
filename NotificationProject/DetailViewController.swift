//
//  DetailViewController.swift
//  NotificationProject
//
//  Created by Георгий Евсеев on 17.03.24.
//

import UIKit


final class DetailViewController: UIViewController {
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

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        view.addSubview(bottomPartofView)
        view.addSubview(textField)
        view.addSubview(textView)
        view.addSubview(picker)
        makeConstraints()
        addRecognizer()
    }

    func makeConstraints() {
        bottomPartofView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.height.equalToSuperview().dividedBy(3)
        }
        
        textView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(Offsets.defaultOffset)
            make.right.equalToSuperview().inset(Offsets.defaultOffset)
            make.height.equalToSuperview().dividedBy(3)
            make.bottom.equalTo(textField.snp.top)
        }

        picker.snp.makeConstraints { make in
            make.left.equalTo(textField.snp.right).offset(Offsets.defaultOffset)
            make.right.equalToSuperview().inset(Insets.defaultInset)
            make.width.equalTo(textView.snp.width).dividedBy(3)
            make.bottom.equalTo(textField.snp.bottom)
            make.height.equalTo(textField.snp.height)
        }

        textField.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(Offsets.defaultOffset)
            make.height.equalTo(44)
            make.bottom.equalTo(bottomPartofView.snp.top)
        }
    }

    func addRecognizer() {
        let tapRecognizer: UITapGestureRecognizer = {
            let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(moveViewController))
            return tapRecognizer
        }()
        bottomPartofView.addGestureRecognizer(tapRecognizer)
    }

    @objc func moveViewController() {
        navigationController?.popViewController(animated: true)
    }
}
