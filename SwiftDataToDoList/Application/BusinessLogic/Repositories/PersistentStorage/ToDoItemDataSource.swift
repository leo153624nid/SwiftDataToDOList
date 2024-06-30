//
//  ToDoItemDataSource.swift
//  SwiftDataToDoList
//
//  Created by A Ch on 30.06.2024.
//

import Foundation
import SwiftData

protocol ToDoItemDataSource {
    func fetchItems(filter: Predicate<ToDoItem>?,
                    sort: [SortDescriptor<ToDoItem>]) -> [ToDoItem]
    func appendItem(item: ToDoItem)
    func removeItem(_ item: ToDoItem)
}

final class DataSource: ToDoItemDataSource {
    private let modelContainer: ModelContainer
    private let modelContext: ModelContext

    @MainActor
    static let shared = DataSource()

    @MainActor
    private init() {
        self.modelContainer = {
            let schema = Schema([
                ToDoItem.self,
            ])
            let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

            do {
                return try ModelContainer(for: schema, configurations: [modelConfiguration])
            } catch {
                fatalError("Could not create ModelContainer: \(error)")
            }
        }()
        self.modelContext = modelContainer.mainContext
    }
    
    func fetchItems(filter: Predicate<ToDoItem>?,
                    sort: [SortDescriptor<ToDoItem>]) -> [ToDoItem] {
        do {
            let fetchDescriptor = FetchDescriptor<ToDoItem>(predicate: filter, sortBy: sort)
            return try modelContext.fetch(fetchDescriptor)
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    func appendItem(item: ToDoItem) {
        modelContext.insert(item)
        do {
            try modelContext.save()
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    func removeItem(_ item: ToDoItem) {
        modelContext.delete(item)
    }
    
}
