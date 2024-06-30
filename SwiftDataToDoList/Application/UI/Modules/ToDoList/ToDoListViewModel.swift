//
//  ToDoListViewModel.swift
//  SwiftDataToDoList
//
//  Created by A Ch on 30.06.2024.
//

import Foundation

@Observable
final class ToDoListViewModel {
    
    @ObservationIgnored
    private let dataSource: ToDoItemDataSource

    var items: [ToDoItem]
    
    var showCreateToDoView = false
    var toDoEditItem: ToDoItem?

    init(dataSource: ToDoItemDataSource = DataSource.shared) {
        self.dataSource = dataSource
//        let predicate = #Predicate<ToDoItem> { $0.isCompleted == false }
        let predicate: Predicate<ToDoItem>? = nil
        let sortDescriptor = SortDescriptor(\ToDoItem.timestamp, order: .forward)
        items = dataSource.fetchItems(filter: predicate,
                                      sort: [sortDescriptor])
    }

    func perform(action: ToDoListAction) {
        switch action {
        case .showCreateToDoView:
            showCreateToDoView.toggle()
        case .showUpdateToDoView(let item):
            guard let item else {
                toDoEditItem = nil
                return
            }
            toDoEditItem = item
        }
    }
}

enum ToDoListAction {
    case showCreateToDoView
    case showUpdateToDoView(item: ToDoItem?)
}
