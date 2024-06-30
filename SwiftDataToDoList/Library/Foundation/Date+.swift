//
//  Date+.swift
//  SwiftDataToDoList
//
//  Created by A Ch on 30.06.2024.
//

import Foundation

public extension Date {
    func component(_ component: Calendar.Component) -> Int {
        let calendar = Calendar.autoupdatingCurrent
        return calendar.component(component, from: self)
    }
    
    var isThisYear: Bool {
        Calendar.current.isDate(self, equalTo: Date(), toGranularity: .year)
    }
    
    var isToday: Bool {
        Calendar.current.isDate(self, equalTo: Date(), toGranularity: .day)
    }
    
    var year: Int {
        return component(.year)
    }
    
    var month: Int {
        return component(.month)
    }
    
    var week: Int {
        return component(.weekday)
    }
    
    var day: Int {
        return component(.day)
    }
    
    var hour: Int {
        return component(.hour)
    }
    
    var minute: Int {
        return component(.minute)
    }
    
    var second: Int {
        return component(.second)
    }
}
