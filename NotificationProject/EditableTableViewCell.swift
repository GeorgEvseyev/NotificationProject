//
//  EditableTableViewCell.swift
//  NotificationProject
//
//  Created by Георгий Евсеев on 10.12.23.
//

import Foundation
import UIKit

class EditableTableViewCell: UITableViewCell {
    static var identifier: String {
        return String(describing: self)
    }

    var closure: (() -> Void)?

    var checkButton: UIButton = {
        let button = CheckPointButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.imageView?.contentMode = .scaleAspectFit
//        button.setImage(UIImage(named: "check"), for: .normal)
//        button.setChecked()
        button.setImage(.check, for: .normal)
        button.setButton()
        return button
    }()

    var cellTextView: UITextView = {
        let cellTextView = UITextView()
        cellTextView.translatesAutoresizingMaskIntoConstraints = false
        cellTextView.isScrollEnabled = false
        
        return cellTextView
    }()

    var cellLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(cellLabel)
        contentView.addSubview(checkButton)
        contentView.addSubview(cellTextView)
        setupCell()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupCell() {

        cellLabel.snp.makeConstraints { make in
            make.height.equalTo(cellTextView.snp.height)
            make.top.left.right.equalTo(contentView)
        }

        checkButton.snp.makeConstraints { make in
            make.height.width.equalTo(44)
            make.left.equalTo(contentView.snp.left)
            make.top.equalTo(contentView.snp.top)
        }

        cellTextView.snp.makeConstraints { make in
            make.height.greaterThanOrEqualTo(44)
            make.top.right.bottom.equalTo(cellLabel)
            make.left.equalTo(contentView.snp.left).inset(60)
        }
    }

    func configure(object: Notification) {
        cellTextView.text = object.text
    }

    func configureButton(with closure: @escaping () -> Void) {
        self.closure = closure
        let action = UIAction { _ in
            self.checkButtonTapped()
        }
        checkButton.addAction(action, for: .touchUpInside)
    }

    func checkButtonTapped() {
        closure?()
    }
}
