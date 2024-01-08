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
    var image: UIImage
    init(cellText: String, cellState: Bool, image: UIImage) {
        self.cellText = cellText
        self.cellState = cellState
        self.image = image
    }
}
