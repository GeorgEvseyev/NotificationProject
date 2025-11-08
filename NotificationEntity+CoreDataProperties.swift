//
//  NotificationEntity+CoreDataProperties.swift
//  NotificationProject
//
//  Created by Георгий Евсеев on 8.11.25.
//
//

import Foundation
import CoreData


typealias NotificationEntityCoreDataPropertiesSet = NSSet

extension NotificationEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NotificationEntity> {
        return NSFetchRequest<NotificationEntity>(entityName: "NotificationEntity")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var text: String?
    @NSManaged public var state: Bool
    @NSManaged public var date: Date?
    @NSManaged public var type: Int16

}

extension NotificationEntity : Identifiable {

}
