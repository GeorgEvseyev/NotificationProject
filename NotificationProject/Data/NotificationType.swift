//
//  NotificationType.swift
//  NotificationProject
//
//  Created by Георгий Евсеев on 8.11.25.
//

import Foundation

enum NotificationType: Int16, Codable {
    case income = 0
    case expense = 1

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let int16Val = try? container.decode(Int16.self) {
            self = NotificationType(rawValue: int16Val) ?? .expense
            return
        }
        if let intVal = try? container.decode(Int.self) {
            self = NotificationType(rawValue: Int16(intVal)) ?? .expense
            return
        }
        if let str = try? container.decode(String.self), let intVal = Int(str) {
            self = NotificationType(rawValue: Int16(intVal)) ?? .expense
            return
        }
        self = .expense
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(self.rawValue)
    }

    var int16Value: Int16 { self.rawValue }
    var intValue: Int { Int(self.rawValue) }
}
