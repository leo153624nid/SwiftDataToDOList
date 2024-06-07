//
//  ContentView.swift
//  SwiftDataToDoList
//
//  Created by A Ch on 07.06.2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {

    var body: some View {
        Group {
            ToDoListView()
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: ToDoItem.self, inMemory: true)
}
