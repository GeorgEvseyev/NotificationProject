//
//  EditableTableViewCell.swift
//  NotificationProject
//
//  Created by Георгий Евсеев on 10.12.23.
//

import Foundation
import UIKit

private enum Constants {
    static let fontSize: CGFloat = 18
    static let defaultSize: CGFloat = 44
    static let defaultText = "default"
}

final class EditableTableViewCell: UITableViewCell, UITextViewDelegate {
    static var identifier: String {
        return String(describing: self)
    }
    
    var viewModel = ViewModel()

    var closure: (() -> Void)?

    var checkButton: UIButton = {
        let checkButton = UIButton()
        checkButton.translatesAutoresizingMaskIntoConstraints = false
        checkButton.imageView?.contentMode = .scaleAspectFit
        return checkButton
    }()

    var cellTextView: UITextView = {
        let cellTextView = UITextView()
        cellTextView.backgroundColor = .white
        cellTextView.translatesAutoresizingMaskIntoConstraints = false
        cellTextView.isScrollEnabled = false
        return cellTextView
    }()

    var cellLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.textColor = .black
        label.font = .systemFont(ofSize: Constants.fontSize)
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
            make.top.equalTo(contentView.snp.top).offset(Offsets.minimumOffset)
            make.left.equalTo(contentView.snp.left).offset(60)
            make.right.equalTo(contentView.snp.right).inset(Insets.minimumInset)
        }

        checkButton.snp.makeConstraints { make in
            make.height.width.equalTo(Constants.defaultSize)
            make.left.equalTo(contentView.snp.left)
            make.centerY.equalTo(contentView.snp.centerY)
        }

        cellTextView.snp.makeConstraints { make in
            make.top.equalTo(cellLabel.snp.bottom).offset(Offsets.minimumOffset)
            make.left.equalTo(contentView.snp.left).offset(60)
            make.right.equalTo(contentView.snp.right).inset(Insets.minimumInset)
            make.bottom.equalTo(contentView.snp.bottom).inset(Insets.minimumInset)
        }
    }

    func configure(notification: Notification, index: Int) {
        cellTextView.tag = index
        if notification.state {
            cellTextView.attributedText = NSMutableAttributedString(string: notification.text)
            cellTextView.isEditable = true
            checkButton.setImage(.uncheck, for: .normal)
        } else {
            cellTextView.attributedText = checked(text: notification.text)
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

    func textViewDidEndEditing(_ textView: UITextView) {
//        print("textViewDidEndEditing")
        if let firstIndex = viewModel.getNotifications().firstIndex(where: { notification in
            notification.id == viewModel.getFilteredNotifications()[textView.tag].id
        }) {
            Manager.shared.notifications[Manager.shared.getDate()]?[firstIndex].text = cellTextView.text ?? Constants.defaultText
            Manager.shared.save()
        }
    }

    func textViewDidBeginEditing(_ textView: UITextView) {
//        print("textViewDidBeginEditing")
    }

    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
//        print("textViewShouldEndEditing")
        return true
    }

    func textViewDidChangeSelection(_ textView: UITextView) {
//        print("textViewDidChangeSelection")
    }

    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
//        print("textViewShouldBeginEditing")
        return true
    }

    func textView(_ textView: UITextView, willDismissEditMenuWith animator: UIEditMenuInteractionAnimating) {
//        print("willDismissEditMenuWith")
    }

    func textView(_ textView: UITextView, willPresentEditMenuWith animator: UIEditMenuInteractionAnimating) {
//        print("willPresentEditMenuWith")
        if let firstIndex = Manager.shared.notifications[Manager.shared.getDate()]?.firstIndex(where: { notification in
            notification.id == viewModel.getFilteredNotifications()[textView.tag].id
        }) {
            Manager.shared.notifications[Manager.shared.getDate()]?[firstIndex].text = cellTextView.text ?? Constants.defaultText
            Manager.shared.save()
        }
//        Manager.shared.delegate?.updateData()
    }

    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
//        print("shouldChangeTextIn")
        return true
    }

    func textViewDidChange(_ textView: UITextView) {
//        print("textViewDidChange")
        cellTextView.snp.prepareConstraints { make in
            make.height.equalTo(textView.snp.height)
        }
        cellLabel.snp.prepareConstraints { make in
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
