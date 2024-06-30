//
//  ToDoItem.swift
//  SwiftDataToDoList
//
//  Created by A Ch on 07.06.2024.
//

import Foundation
import SwiftData

@Model
final class ToDoItem {
    var title: String
    var timestamp: Date
    var isCritical: Bool
    var isCompleted: Bool
    
    enum Group: Int, CaseIterable, Identifiable {
        case past = 0
        case today
        case upcoming
        
        var id: Int { self.rawValue }
        
        func labelTitle() -> String {
            switch self {
            case .past: "Past"
            case .today: "Today"
            case .upcoming: "Upcoming & Overdue"
            }
        }
    }
    
    var group: Group {
        if timestamp.isToday {
            return .today
        } else if !isCompleted {
            return .upcoming
        }
        return .past
    }
    
    init(title: String = "",
         timestamp: Date = .now,
         isCritical: Bool = false,
         isCompleted: Bool = false) {
        
        self.title = title
        self.timestamp = timestamp
        self.isCritical = isCritical
        self.isCompleted = isCompleted
    }
}
