//
//  ToDoListView.swift
//  SwiftDataToDoList
//
//  Created by A Ch on 07.06.2024.
//

import Foundation
import SwiftUI
import SwiftData

struct ToDoListView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [ToDoItem]
    
    @State private var showCreateToDoView = false

    var body: some View {
        NavigationStack {
            List {
                ForEach(items) { item in
                    NavigationLink {
                        Text("Item at \(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))")
                    } label: {
                        Text(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))
                    }
                }
//                .onDelete(perform: deleteItems)
            }
            .toolbar {
                toolBarCreateItem
                
                if !items.isEmpty {
                    toolBarEditItem
                }
            }
        }
        .sheet(isPresented: $showCreateToDoView) {
            NavigationStack {
                CreateToDoView()
            }
            .presentationDetents([.medium])
        }
    }
    
    private var toolBarCreateItem: some ToolbarContent {
        ToolbarItem {
            Button {
                showCreateToDoView.toggle()
            } label: {
                Label("Add Item", systemImage: "plus")
            }
        }
    }
    
    private var toolBarEditItem: some ToolbarContent {
        ToolbarItem {
            EditButton()
        }
    }

//    private func addItem() {
//        withAnimation {
//            let newItem = ToDoItem(timestamp: Date())
//            modelContext.insert(newItem)
//        }
//    }

//    private func deleteItems(offsets: IndexSet) {
//        withAnimation {
//            for index in offsets {
//                modelContext.delete(items[index])
//            }
//        }
//    }
}

#Preview {
    ToDoListView()
        .modelContainer(for: ToDoItem.self, inMemory: true)
}
