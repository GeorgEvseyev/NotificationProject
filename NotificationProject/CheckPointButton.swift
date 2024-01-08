
//  CheckPoint.swift
//  NotificationProject
//
//  Created by Георгий Евсеев on 11.12.23.


//import Foundation
//import UIKit
//
//class CheckPointButton: UIButton {
//
//    var isChecked: Bool = false {
//        didSet {
//            if isChecked {
//                setImage(.check, for: .normal)
//            } else {
//                setImage(.uncheck, for: .normal)
//            }
//        }
//    }
//
//    func setButton() {
//        let action = UIAction { _ in
//            self.tapButton(sender: self)
//        }
//
//        addAction(action, for: .touchUpInside)
//    }
//
//    func tapButton(sender: UIButton) {
//        isChecked = !isChecked
//    }
//
//    func setChecked() {
//        self.isChecked = true
//    }
//
//    func setUnChecked() {
//        self.isChecked = false
//    }
//}
