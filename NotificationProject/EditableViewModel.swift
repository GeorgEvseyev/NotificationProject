//
//  EditableViewModel.swift
//  NotificationProject
//
//  Created by Георгий Евсеев on 2.01.24.
//

import Foundation
import UIKit

final class EditableViewModel {
    var cellText: String
    var cellState: Bool
    init(cellText: String, cellState: Bool) {
        self.cellText = cellText
        self.cellState = cellState
    }
    
    func configureUncheckCell(cell: EditableTableViewCell) {
        cell.cellTextView.attributedText = checked(text: cellText)
    }
    
    func configureCheckCell(cell: EditableTableViewCell) {
        cell.cellTextView.text = cellText
    }
    
    func checked(text: String) -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSUnderlineStyle.thick.rawValue, range: NSMakeRange(0, attributedString.length))
        attributedString.addAttribute(NSAttributedString.Key.strikethroughColor, value: UIColor.black, range: NSMakeRange(0, attributedString.length))
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.gray, range: NSMakeRange(0, attributedString.length))
        return attributedString
    }
}
