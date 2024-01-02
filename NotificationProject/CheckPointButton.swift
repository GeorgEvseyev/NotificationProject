//
//  CheckPoint.swift
//  NotificationProject
//
//  Created by Георгий Евсеев on 11.12.23.
//

import Foundation
import UIKit

class CheckPointButton: UIButton {
    private let checkImage = UIImage(named: "check")
    private let uncheckImage = UIImage(named: "uncheck")
    var isChecked: Bool = false {
        didSet {
            if isChecked {
                self.setImage(checkImage, for: .normal)
            } else {
                self.setImage(uncheckImage, for: .normal)
            }
        }
    }

    func setButton() {
        let action = UIAction { _ in
            self.tapButton(sender: self)
        }

        addAction(action, for: .touchUpInside)
        isChecked = false
    }

    func tapButton(sender: UIButton) {
        isChecked = !isChecked
    }
    
    func setChecked() {
        self.isChecked = true
    }
    
    func setUnChecked() {
        self.isChecked = false
    }
}
