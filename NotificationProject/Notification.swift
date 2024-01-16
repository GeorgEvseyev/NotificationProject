//
//  Notification.swift
//  NotificationProject
//
//  Created by Георгий Евсеев on 5.12.23.
//

import Foundation

final class Notification: Codable {
    var id: UUID
    var text: String
    var state: Bool
    init(text: String, state: Bool) {
        self.text = text
        id = UUID()
        self.state = state
    }
}
