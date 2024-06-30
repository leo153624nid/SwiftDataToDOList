//
//  SwiftDataToDoListApp.swift
//  SwiftDataToDoList
//
//  Created by A Ch on 07.06.2024.
//

import SwiftUI
import SwiftData

@main
struct SwiftDataToDoListApp: App {
    
    var sharedModelContainer: ModelContainer = {
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

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
