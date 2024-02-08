//
//  Notification.swift
//  NotificationProject
//
//  Created by Георгий Евсеев on 5.12.23.
//

import Foundation

final class Notification: Codable {
    var date: Int
    var number: Int
    var id: UUID
    var text: String
    var state: Bool

    init(date: Int, number: Int, text: String, state: Bool) {
        self.date = date
        self.number = number
        self.text = text
        id = UUID()
        self.state = state
    }
}
