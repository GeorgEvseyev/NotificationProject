//
//  EditableTableViewCell.swift
//  NotificationProject
//
//  Created by Георгий Евсеев on 10.12.23.
//

import Foundation
import UIKit

class EditableTableViewCell: UITableViewCell, UITextViewDelegate {
    static var identifier: String {
        return String(describing: self)
    }

    var closure: (() -> Void)?

    var checkButton: UIButton = {
        let checkButton = UIButton()
        checkButton.translatesAutoresizingMaskIntoConstraints = false
        checkButton.imageView?.contentMode = .scaleAspectFit
        return checkButton
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
        cellTextView.delegate = self
        setupCell()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupCell() {
        cellLabel.snp.remakeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(8)
            make.left.equalTo(contentView.snp.left).offset(60)
            make.right.equalTo(contentView.snp.right).inset(8)
        }

        checkButton.snp.makeConstraints { make in
            make.height.width.equalTo(44)
            make.left.equalTo(contentView.snp.left)
            make.centerY.equalTo(contentView.snp.centerY)
        }

        cellTextView.snp.makeConstraints { make in
            make.top.equalTo(cellLabel.snp.bottom).offset(8)
            make.left.equalTo(contentView.snp.left).offset(60)
            make.right.equalTo(contentView.snp.right).inset(8)
            make.bottom.equalTo(contentView.snp.bottom).inset(8)
        }
    }

    func configure(with index: Int) {
        cellTextView.tag = index
        if Manager.shared.notifications[index].state {
            cellTextView.attributedText = NSMutableAttributedString(string: Manager.shared.notifications[index].text)
            cellTextView.isEditable = true
            checkButton.setImage(.uncheck, for: .normal)
        } else {
            cellTextView.attributedText = checked(text: Manager.shared.notifications[index].text)
            cellTextView.isEditable = false
            checkButton.setImage(.check, for: .normal)
        }
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

    func textViewDidBeginEditing(_ textView: UITextView) {
        cellTextView.keyboardAppearance = .default
        print("ok")
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        let index = textView.tag
        let text = cellTextView.text ?? "is empty"
        Manager.shared.addNotificationText(index: index, text: text)
        Manager.shared.delegate?.updateData()
        cellTextView.snp.makeConstraints { make in
            make.height.equalTo(textView.snp.height)
        }
        cellLabel.snp.makeConstraints { make in
            make.height.equalTo(cellTextView.snp.height)
        }
    }

    func checked(text: String) -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSUnderlineStyle.thick.rawValue, range: NSMakeRange(0, attributedString.length))
        attributedString.addAttribute(NSAttributedString.Key.strikethroughColor, value: UIColor.black, range: NSMakeRange(0, attributedString.length))
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.gray, range: NSMakeRange(0, attributedString.length))
        return attributedString
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        cellTextView.text = nil
        checkButton.setImage(nil, for: .normal)
        closure = nil
    }
}
