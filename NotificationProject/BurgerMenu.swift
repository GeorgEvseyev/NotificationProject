//
//  BurgerMenu.swift
//  NotificationProject
//
//  Created by Георгий Евсеев on 26.12.23.
//

import UIKit
import SnapKit

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
        
        
//        firstRectangle.snp.makeConstraints { make in
//            make.width.equalToSuperview()
//            make.height.equalTo(20)
//            make.top.equalToSuperview().inset(0)
//        }
//        
//        secondRectangle.snp.makeConstraints { make in
//            make.width.equalToSuperview()
//            make.top.equalTo(firstRectangle.snp.bottom).inset(4)
//            make.height.equalTo(20)
//        }
//        
//        thirdRectangle.snp.makeConstraints { make in
//            make.width.equalToSuperview()
//            make.top.equalTo(secondRectangle.snp.bottom).inset(4)
//            make.height.equalTo(20)
//        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
