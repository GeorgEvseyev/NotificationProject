//
//  Notification.swift
//  NotificationProject
//
//  Created by Георгий Евсеев on 5.12.23.
//

import Foundation

//final class Notification: NSObject, NSCoding {
final class Notification: Codable {

    
    var date: String
    var number: Int
    var id: UUID
    var text: String
    var state: Bool

    init(date: String, number: Int, text: String, state: Bool) {
        self.date = date
        self.number = number
        self.text = text
        id = UUID()
        self.state = state
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(date, forKey: "date")
        aCoder.encode(number, forKey: "number")
        aCoder.encode(id, forKey: "id")
        aCoder.encode(text, forKey: "text")
        aCoder.encode(state, forKey: "state")
    }
    
    required init(coder aDecoder: NSCoder) {
        date = aDecoder.decodeObject(forKey: "date") as? String ?? ""
        number = aDecoder.decodeInteger(forKey: "number")
        id = aDecoder.decodeObject(forKey: "id") as? UUID ?? UUID()
        text = aDecoder.decodeObject(forKey: "text") as? String ?? ""
        state = aDecoder.decodeBool(forKey: "state")
    }
}
