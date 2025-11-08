
//
//  Notification.swift
//  NotificationProject
//
//  Created by Георгий Евсеев on 5.12.23.
//

import Foundation

struct MyNotification: Identifiable, Codable {
    let id: UUID
    var text: String
    /// dd.MM.yyyy
    var date: String
    var number: Int
    /// false = active, true = done
    var state: Bool
    var type: NotificationType

    init(id: UUID = UUID(),
         text: String,
         date: String,
         number: Int = 0,
         state: Bool = false,
         type: NotificationType = .expense) {
        self.id = id
        self.text = text
        self.date = date
        self.number = number
        self.state = state
        self.type = type
    }
}





//import Foundation
//
////final class Notification: NSObject, NSCoding {
//class MyNotification: Codable {
//
//    var date: String
//    var number: Int
//    var id: UUID
//    var text: String
//    var state: Bool
//
//    init(date: String, number: Int, text: String, state: Bool) {
//        self.date = date
//        self.number = number
//        self.text = text
//        id = UUID()
//        self.state = state
//    }
//    
//    func encode(with aCoder: NSCoder) {
//        aCoder.encode(date, forKey: "date")
//        aCoder.encode(number, forKey: "number")
//        aCoder.encode(id, forKey: "id")
//        aCoder.encode(text, forKey: "text")
//        aCoder.encode(state, forKey: "state")
//    }
//    
//    required init(coder aDecoder: NSCoder) {
//        date = aDecoder.decodeObject(forKey: "date") as? String ?? ""
//        number = aDecoder.decodeInteger(forKey: "number")
//        id = aDecoder.decodeObject(forKey: "id") as? UUID ?? UUID()
//        text = aDecoder.decodeObject(forKey: "text") as? String ?? ""
//        state = aDecoder.decodeBool(forKey: "state")
//    }
//}
//
//extension MyNotification: Equatable {
//    static func == (lhs: MyNotification, rhs: MyNotification) -> Bool {
//        lhs.state == rhs.state && lhs.text == rhs.text && lhs.id == rhs.id && lhs.date == rhs.date
//    }
//}
