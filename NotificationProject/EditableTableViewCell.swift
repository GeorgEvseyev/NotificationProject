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

    var viewModel: EditableViewModel?
    
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
    
    func configure(notification: Notification) {
        viewModel = EditableViewModel(cell: self, notification: notification)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        cellTextView.text = nil
        checkButton.setImage(nil, for: .normal)
        viewModel?.closure = nil
    }
}
