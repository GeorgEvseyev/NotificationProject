//
//  EditableViewModel.swift
//  NotificationProject
//
//  Created by Георгий Евсеев on 2.01.24.
//

import Foundation
import UIKit

final class EditableViewModel {
        private let checkImage = UIImage(named: "check")
        private let uncheckImage = UIImage(named: "uncheck")
    var cellText: String
    var cellState: Bool
    var image: UIImage
    init(cellText: String, cellState: Bool, image: UIImage) {
        self.cellText = cellText
        self.cellState = cellState
        self.image = image
    }
    
    func configureUncheckCell(cell: EditableTableViewCell, index: Int) {
        cellText = Manager.shared.notifications[index].text
        cellState = Manager.shared.notifications[index].state
        cell.cellTextView.attributedText = checked(text: Manager.shared.notifications[index].text)
        cell.cellTextView.isUserInteractionEnabled = false
    }
    
    func configureCheckCell(cell: EditableTableViewCell, index: Int) {
        cellText = Manager.shared.notifications[index].text
        cellState = Manager.shared.notifications[index].state
        Manager.shared.notifications[index].text = cell.cellTextView.text
        cell.cellTextView.text = Manager.shared.notifications[index].text
    }
    
    func checked(text: String) -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSUnderlineStyle.thick.rawValue, range: NSMakeRange(0, attributedString.length))
        attributedString.addAttribute(NSAttributedString.Key.strikethroughColor, value: UIColor.black, range: NSMakeRange(0, attributedString.length))
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.gray, range: NSMakeRange(0, attributedString.length))
        return attributedString
    }
}
