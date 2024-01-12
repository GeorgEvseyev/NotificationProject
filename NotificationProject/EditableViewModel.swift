//
//  EditableViewModel.swift
//  NotificationProject
//
//  Created by Георгий Евсеев on 2.01.24.
//

import Foundation
import UIKit

final class EditableViewModel {
    
    var cell: EditableTableViewCell
    var notification: Notification
    
    var closure: (() -> Void)?

    init(cell: EditableTableViewCell, notification: Notification) {
        self.cell = cell
        self.notification = notification
    }
    
    func configureButton(with closure: @escaping () -> Void) {
        self.closure = closure
        let action = UIAction { _ in
            self.checkButtonTapped()
        }
        cell.checkButton.addAction(action, for: .touchUpInside)
    }

    func checkButtonTapped() {
        closure?()
    }
    
    func configureCell(cell: EditableTableViewCell, notification: Notification) {
        if notification.state {
            cell.checkButton.setImage(.uncheck, for: .normal)
            cell.cellTextView.text = notification.text
        } else {
            cell.checkButton.setImage(.check, for: .normal)
            cell.cellTextView.attributedText = checked(text: notification.text)
            cell.cellTextView.isEditable = false
        }
    }

    func checked(text: String) -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSUnderlineStyle.thick.rawValue, range: NSMakeRange(0, attributedString.length))
        attributedString.addAttribute(NSAttributedString.Key.strikethroughColor, value: UIColor.black, range: NSMakeRange(0, attributedString.length))
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.gray, range: NSMakeRange(0, attributedString.length))
        return attributedString
    }
}


