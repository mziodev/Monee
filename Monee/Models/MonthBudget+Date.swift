//
//  MonthBudget+Date.swift
//  Monee
//
//  Created by MZiO on 20/8/24.
//

import Foundation

extension MonthBudget {
    var monthNumber: Int {
        Calendar.current.dateComponents([.month], from: creationDate).month ?? 0
    }
    
    var monthName: String {
        creationDate.formatted(.dateTime.month(.wide))
    }
    
    var yearName: String {
        creationDate.formatted(.dateTime.year(.extended()))
    }
    
    var durationRange: ClosedRange<Date> {
        let calendar = Calendar.current
        var components = calendar.dateComponents([.year, .month], from: creationDate)
        
        components.day = 1
        let startDate = calendar.date(from: components)!
    
        components.month! += 1
        components.day = 0 //last day of the month
        let endDate = calendar.date(from: components)!
        
        
        return startDate...endDate
    }
    
    var matchesCurrentMonth: Bool {
        monthName.contains(Date.now.formatted(.dateTime.month(.wide)))
    }
}
