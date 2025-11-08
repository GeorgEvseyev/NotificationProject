//
//  EditableTableViewCell.swift
//  NotificationProject
//
//  Created by Георгий Евсеев on 10.12.23.
//

import UIKit
import SnapKit

private enum Constants {
    static let fontSize: CGFloat = 18
    static let defaultSize: CGFloat = 44
    static let defaultText = "default"
}

protocol IEditableTableViewCell: AnyObject {
    static var identifier: String { get }

    func configure(notification: MyNotification)
    func setLabelText(_ text: String)
    func setText(_ text: String)

    func configureButton(with closure: @escaping () -> Void)
    func configureDetailButton(with closure: @escaping () -> Void)
    func configureTextChanged(with closure: @escaping (String) -> Void)
}

final class EditableTableViewCell: UITableViewCell, UITextViewDelegate, IEditableTableViewCell {
    static var identifier: String { String(describing: self) }

    // MARK: - Closures
    private var checkButtonClosure: (() -> Void)?
    private var detailButtonClosure: (() -> Void)?
    private var textChangedClosure: ((String) -> Void)?

    // MARK: - UI
    private let checkButton: UIButton = {
        var conf = UIButton.Configuration.plain()
        conf.image = UIImage(systemName: "circle")
        conf.cornerStyle = .capsule
        conf.baseForegroundColor = .tintColor
        let button = UIButton(configuration: conf)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let detailButton: UIButton = {
        var conf = UIButton.Configuration.tinted()
        conf.image = UIImage(systemName: "pencil")
        conf.cornerStyle = .capsule
        let button = UIButton(configuration: conf)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let cellTextView: UITextView = {
        let tv = UITextView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.isScrollEnabled = false
        tv.backgroundColor = .clear
        tv.textColor = .label
        tv.font = .preferredFont(forTextStyle: .body)
        tv.adjustsFontForContentSizeCategory = true
        tv.textContainerInset = .zero
        tv.textContainer.lineFragmentPadding = 0
        return tv
    }()

    private let cellLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.textColor = .label
        label.font = .systemFont(ofSize: Constants.fontSize, weight: .regular)
        label.adjustsFontForContentSizeCategory = true
        return label
    }()

    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        contentView.layoutMargins = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        cellTextView.delegate = self
        setupLayout()
        wireActions()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Layout
    private func setupLayout() {
        contentView.addSubview(cellLabel)
        contentView.addSubview(checkButton)
        contentView.addSubview(detailButton)
        contentView.addSubview(cellTextView)

        cellLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.layoutMarginsGuide.snp.top).offset(8)
            make.left.equalTo(contentView.snp.left).offset(60)
            make.right.equalTo(contentView.layoutMarginsGuide.snp.right)
        }

        checkButton.snp.makeConstraints { make in
            make.height.width.equalTo(Constants.defaultSize)
            make.left.equalTo(contentView.snp.left)
            make.centerY.equalTo(contentView.snp.centerY)
        }

        detailButton.snp.makeConstraints { make in
            make.height.width.equalTo(Constants.defaultSize)
            make.right.equalTo(contentView.layoutMarginsGuide.snp.right)
            make.centerY.equalTo(contentView.snp.centerY)
        }

        cellTextView.snp.makeConstraints { make in
            make.top.equalTo(cellLabel.snp.bottom).offset(8)
            make.left.equalTo(contentView.snp.left).offset(60)
            make.right.equalTo(contentView.layoutMarginsGuide.snp.right)
            make.bottom.equalTo(contentView.layoutMarginsGuide.snp.bottom)
        }
    }

    // MARK: - Configure
    func configure(notification: MyNotification) {
        if notification.state {
            // выполненная заметка
            checkButton.configuration?.image = UIImage(systemName: "checkmark.circle.fill")
            cellTextView.isEditable = false
            cellTextView.attributedText = checked(text: notification.text)
        } else {
            // активная заметка
            checkButton.configuration?.image = UIImage(systemName: "circle")
            cellTextView.isEditable = true

            // ⚡️ гарантированный сброс атрибутов
            let plain = NSAttributedString(
                string: notification.text,
                attributes: [
                    .foregroundColor: UIColor.label,
                    .font: UIFont.preferredFont(forTextStyle: .body)
                ]
            )
            cellTextView.attributedText = plain
        }
    }

    func setLabelText(_ text: String) {
        cellLabel.text = text
    }

    func setText(_ text: String) {
        cellTextView.text = text
    }

    // MARK: - Actions binding
    private func wireActions() {
        checkButton.addAction(UIAction { [weak self] _ in
            self?.checkButtonClosure?()
        }, for: .touchUpInside)

        detailButton.addAction(UIAction { [weak self] _ in
            self?.detailButtonClosure?()
        }, for: .touchUpInside)
    }

    func configureButton(with closure: @escaping () -> Void) {
        self.checkButtonClosure = closure
    }

    func configureDetailButton(with closure: @escaping () -> Void) {
        self.detailButtonClosure = closure
    }

    func configureTextChanged(with closure: @escaping (String) -> Void) {
        self.textChangedClosure = closure
    }

    // MARK: - UITextViewDelegate
    func textViewDidChange(_ textView: UITextView) {
        textChangedClosure?(textView.text ?? Constants.defaultText)
    }

    // MARK: - Checked style
    private func checked(text: String) -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(.strikethroughStyle,
                                      value: NSUnderlineStyle.single.rawValue,
                                      range: NSRange(location: 0, length: attributedString.length))
        attributedString.addAttribute(.foregroundColor,
                                      value: UIColor.secondaryLabel,
                                      range: NSRange(location: 0, length: attributedString.length))
        attributedString.addAttribute(.strikethroughColor,
                                      value: UIColor.secondaryLabel,
                                      range: NSRange(location: 0, length: attributedString.length))
        return attributedString
    }

    // MARK: - Reuse
    override func prepareForReuse() {
        super.prepareForReuse()
        cellTextView.attributedText = nil
        cellTextView.text = nil
        cellTextView.textColor = .label
        cellTextView.font = .preferredFont(forTextStyle: .body)
        cellTextView.isEditable = true
        checkButton.configuration?.image = UIImage(systemName: "circle")
        detailButton.configuration?.image = UIImage(systemName: "pencil")
        checkButtonClosure = nil
        detailButtonClosure = nil
        textChangedClosure = nil
    }
}







////
////  EditableTableViewCell.swift
////  NotificationProject
////
////  Created by Георгий Евсеев on 10.12.23.
////
//
//import Foundation
//import UIKit
//import SnapKit
//
//private enum Constants {
//    static let fontSize: CGFloat = 18
//    static let defaultSize: CGFloat = 44
//    static let defaultText = "default"
//}
//
//protocol IEditableTableViewCell {
//    func setupCell()
//    func configure(notification: MyNotification, index: Int)
//    func configureButton(with closure: @escaping () -> Void)
//    func configureDetailButton(with closure: @escaping () -> Void)
//    func checkButtonTapped()
//    func detailButtonTapped()
//    func checked(text: String) -> NSMutableAttributedString
//}
//
//final class EditableTableViewCell: UITableViewCell, UITextViewDelegate {
//    static var identifier: String {
//        return String(describing: self)
//    }
//    
//    // ViewModel оставляем для совместимости, но стараемся не трогать глобальное состояние из ячейки
//    var viewModel = ViewModel()
//    
//    // Замыкания для действий (как у тебя было)
//    var checkButtonClosure: (() -> Void)?
//    var detailButtonClosure: (() -> Void)?
//    
//    // MARK: - UI
//    
//    // Современные кнопки через UIButton.Configuration
//    var checkButton: UIButton = {
//        var conf = UIButton.Configuration.plain()
//        conf.image = UIImage(systemName: "circle")
//        conf.cornerStyle = .capsule
//        conf.baseForegroundColor = .tintColor
//        let button = UIButton(configuration: conf)
//        button.translatesAutoresizingMaskIntoConstraints = false
//        button.imageView?.contentMode = .scaleAspectFit
//        return button
//    }()
//    
//    var detailButton: UIButton = {
//        var conf = UIButton.Configuration.tinted()
//        conf.image = UIImage(systemName: "pencil")
//        conf.cornerStyle = .capsule
//        let button = UIButton(configuration: conf)
//        button.translatesAutoresizingMaskIntoConstraints = false
//        return button
//    }()
//    
//    var cellTextView: UITextView = {
//        let tv = UITextView()
//        tv.translatesAutoresizingMaskIntoConstraints = false
//        tv.isScrollEnabled = false
//        tv.backgroundColor = .clear
//        tv.textColor = .label
//        tv.font = .preferredFont(forTextStyle: .body)
//        tv.adjustsFontForContentSizeCategory = true
//        tv.textContainerInset = .zero
//        tv.textContainer.lineFragmentPadding = 0
//        return tv
//    }()
//    
//    var cellLabel: UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.backgroundColor = .clear
//        label.textColor = .label
//        // Оставляем твой размер шрифта, но лучше использовать Dynamic Type:
//        // label.font = .preferredFont(forTextStyle: .body)
//        label.font = .systemFont(ofSize: Constants.fontSize, weight: .regular)
//        label.adjustsFontForContentSizeCategory = true
//        return label
//    }()
//    
//    // MARK: - Init
//    
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        selectionStyle = .none
//        contentView.layoutMargins = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
//        cellTextView.delegate = self
//        setupCell()
//        wireActions()
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    // MARK: - Layout
//    
//    func setupCell() {
//        contentView.addSubview(cellLabel)
//        contentView.addSubview(checkButton)
//        contentView.addSubview(detailButton)
//        contentView.addSubview(cellTextView)
//        
//        // label
//        cellLabel.snp.remakeConstraints { make in
//            make.top.equalTo(contentView.layoutMarginsGuide.snp.top).offset(Offsets.minimumOffset)
//            make.left.equalTo(contentView.snp.left).offset(60)
//            make.right.equalTo(contentView.layoutMarginsGuide.snp.right)
//        }
//        
//        // check button
//        checkButton.snp.makeConstraints { make in
//            make.height.width.equalTo(Constants.defaultSize)
//            make.left.equalTo(contentView.snp.left)
//            make.centerY.equalTo(contentView.snp.centerY)
//        }
//        
//        // detail button
//        detailButton.snp.makeConstraints { make in
//            make.height.width.equalTo(Constants.defaultSize)
//            make.right.equalTo(contentView.layoutMarginsGuide.snp.right)
//            make.centerY.equalTo(contentView.snp.centerY)
//        }
//        
//        // text view
//        cellTextView.snp.makeConstraints { make in
//            make.top.equalTo(cellLabel.snp.bottom).offset(Offsets.minimumOffset)
//            make.left.equalTo(contentView.snp.left).offset(60)
//            make.right.equalTo(contentView.layoutMarginsGuide.snp.right)
//            make.bottom.equalTo(contentView.layoutMarginsGuide.snp.bottom)
//        }
//    }
//    
//    // MARK: - Configure
//    
//    func configure(notification: MyNotification, index: Int) {
//        cellTextView.tag = index
//        
//        if notification.state == true {
//            // Активная запись — редактируемая
//            checkButton.configuration?.image = UIImage(systemName: "circle")
//            cellTextView.isEditable = true
//            cellTextView.attributedText = NSAttributedString(string: notification.text)
//        } else {
//            // Выполненная — зачеркнутая
//            checkButton.configuration?.image = UIImage(systemName: "checkmark.circle.fill")
//            cellTextView.isEditable = false
//            cellTextView.attributedText = checked(text: notification.text)
//        }
//    }
//    
//    // MARK: - Actions binding
//    
//    func wireActions() {
//        checkButton.removeTarget(nil, action: nil, for: .allEvents)
//        let checkAction = UIAction { [weak self] _ in
//            self?.checkButtonTapped()
//        }
//        checkButton.addAction(checkAction, for: .touchUpInside)
//        
//        detailButton.removeTarget(nil, action: nil, for: .allEvents)
//        let detailAction = UIAction { [weak self] _ in
//            self?.detailButtonTapped()
//        }
//        detailButton.addAction(detailAction, for: .touchUpInside)
//    }
//    
//    func configureButton(with closure: @escaping () -> Void) {
//        self.checkButtonClosure = closure
//        // wireActions уже назначает действие; тут можно не переназначать
//    }
//    
//    func configureDetailButton(with closure: @escaping () -> Void) {
//        self.detailButtonClosure = closure
//        // wireActions уже назначает действие; тут можно не переназначать
//    }
//    
//    func checkButtonTapped() {
//        checkButtonClosure?()
//    }
//    
//    func detailButtonTapped() {
//        detailButtonClosure?()
//    }
//    
//    // MARK: - UITextViewDelegate
//    
//    func textViewDidEndEditing(_ textView: UITextView) {
//        // Централизуем сохранение текста в одном месте
//        if let firstIndex = viewModel.getNotifications().firstIndex(where: { notification in
//            notification.id == viewModel.getFilteredNotifications()[textView.tag].id
//        }) {
//            Manager.shared.notifications[Manager.shared.getDate()]?[firstIndex].text = cellTextView.text ?? Constants.defaultText
//            StorageService().saveNotifications()
//        }
//    }
//    
//    func textViewShouldEndEditing(_ textView: UITextView) -> Bool { true }
//    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool { true }
//    
//    func textView(_ textView: UITextView, willPresentEditMenuWith animator: UIEditMenuInteractionAnimating) {
//        // Сохраняем перед показом меню редактирования
//        if let firstIndex = Manager.shared.notifications[Manager.shared.getDate()]?.firstIndex(where: { notification in
//            notification.id == viewModel.getFilteredNotifications()[textView.tag].id
//        }) {
//            Manager.shared.notifications[Manager.shared.getDate()]?[firstIndex].text = cellTextView.text ?? Constants.defaultText
//            StorageService().saveNotification()
//        }
//    }
//    
//    // Важно: не меняем констрейнты в процессе ввода — таблица сама пересчитает высоту
//    func textViewDidChange(_ textView: UITextView) { }
//    
//    // MARK: - Checked style
//    
//    func checked(text: String) -> NSMutableAttributedString {
//        let attributedString = NSMutableAttributedString(string: text)
//        // Аккуратное зачёркивание с семантическими цветами
//        attributedString.addAttribute(.strikethroughStyle,
//                                      value: NSUnderlineStyle.single.rawValue,
//                                      range: NSRange(location: 0, length: attributedString.length))
//        attributedString.addAttribute(.foregroundColor,
//                                      value: UIColor.secondaryLabel,
//                                      range: NSRange(location: 0, length: attributedString.length))
//        attributedString.addAttribute(.strikethroughColor,
//                                      value: UIColor.secondaryLabel,
//                                      range: NSRange(location: 0, length: attributedString.length))
//        return attributedString
//    }
//    
//    // MARK: - Reuse
//    
//    override func prepareForReuse() {
//        super.prepareForReuse()
//        cellTextView.text = nil
//        cellTextView.attributedText = nil
//        cellTextView.isEditable = true
//        // Сбрасываем изображения через configuration
//        checkButton.configuration?.image = UIImage(systemName: "circle")
//        detailButton.configuration?.image = UIImage(systemName: "pencil")
//        checkButtonClosure = nil
//        detailButtonClosure = nil
//        // Не сбрасываем delegate, он назначен в init и нужен для событий ввода
//        isSelected = false
//        isHighlighted = false
//    }
//}
