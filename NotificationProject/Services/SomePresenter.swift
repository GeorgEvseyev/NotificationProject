//
//  NewClass.swift
//  NotificationProject
//
//  Created by Георгий Евсеев on 8.09.24.
//

import Foundation

protocol ISomePresenter {
    func first()
    func second() -> String
    func third(parameter: Int)
    func four(parameter: String) -> String
}

final class SomePresenter {
    func first() {
        
    }
    
    func second() -> String {
        return ""
    }
    
    func third(parameter: Int) {
        
    }
    
    func four(parameter: String) -> String {
        return "String"
    }
    
}
