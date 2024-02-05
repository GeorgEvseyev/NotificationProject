//
//  CalendarViewDelegate.swift
//  NotificationProject
//
//  Created by Георгий Евсеев on 1.02.24.
//

import Foundation
import UIKit

class CalendarViewDelegate: NSObject, UICalendarViewDelegate {
    
    func calendarView(_ calendarView: UICalendarView, didSelectDateComponents dateComponents: DateComponents) {

        print(dateComponents)
    }
}
