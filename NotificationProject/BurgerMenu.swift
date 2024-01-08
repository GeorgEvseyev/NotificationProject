//
//  BurgerMenu.swift
//  NotificationProject
//
//  Created by Георгий Евсеев on 26.12.23.
//

import SnapKit
import UIKit

class BurgerMenu: UIView {
    private let firstRectangle = Rectangle()
    private let secondRectangle = Rectangle()
    private let thirdRectangle = Rectangle()

    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(firstRectangle)
        addSubview(secondRectangle)
        addSubview(thirdRectangle)

        firstRectangle.frame = CGRect(x: 0, y: 0, width: 44, height: 12)
        secondRectangle.frame = CGRect(x: 0, y: 16, width: 44, height: 12)
        thirdRectangle.frame = CGRect(x: 0, y: 32, width: 44, height: 12)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
