//
//  CalendarViewDelegate.swift
//  NotificationProject
//
//  Created by Георгий Евсеев on 1.02.24.
//

import Foundation
import UIKit

final class CalendarViewDelegate: NSObject, UICalendarViewDelegate {
    
    var calendarView: UICalendarView? = nil
    var decorations: [Date?: UICalendarView.Decoration]
    
    
    override init() {
        
        let valentinesDay = DateComponents(
            year: 2024,
            month: 2,
            day: 14
        )
        
        
        let heart = UICalendarView.Decoration.image(UIImage(systemName: "heart.fill"),
                                                    color: UIColor.red,
                                                    size: .large
        )
        
        decorations = [valentinesDay.date: heart]
    }
    
    func calendarView(_ calenarView: UICalendarView, decorationFor dateComponents: DateComponents) -> UICalendarView.Decoration? {
        
        let day = DateComponents(
            calendar: dateComponents.calendar,
            year: dateComponents.year,
            month: dateComponents.month,
            day: dateComponents.day
        )
        return decorations[day.date]
    }
}
