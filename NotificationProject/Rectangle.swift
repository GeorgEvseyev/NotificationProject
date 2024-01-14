//
//  Rectangle.swift
//  NotificationProject
//
//  Created by Георгий Евсеев on 26.12.23.
//

import UIKit

class Rectangle: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = .white
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
