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
    @Query(
//        filter: #Predicate<ToDoItem> { $0.isCompleted == false },
        sort: \ToDoItem.timestamp,
        order: .reverse
    ) private var items: [ToDoItem]
    
    @State private var toDoEditItem: ToDoItem?
    @State private var showCreateToDoView = false

    var body: some View {
        NavigationStack {
            List {
                ForEach(items) { item in
                    // TODO: make sections
                    toDoCell(with: item)
                        .swipeActions {
                            deleteActionButton(for: item)
                            editActionButton(for: item)
                        }
                }
            }
            .navigationTitle("My To Do List")
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
        .sheet(item: $toDoEditItem) {
            toDoEditItem = nil
        } content: { item in
            UpdateToDoView(item: item)
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
    
    private func toDoCell(with item: ToDoItem) -> some View {
        HStack {
            VStack(alignment: .leading) {
                if item.isCritical {
                    Image(systemName: "exclamationmark.3")
                        .symbolVariant(.fill)
                        .foregroundColor(.red)
                        .font(.largeTitle)
                        .bold()
                }
                
                Text(item.title)
                    .font(.largeTitle)
                    .bold()
                
                Text("\(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .shortened))")
                    .font(.callout)
            }
            
            Spacer()
            
            Button {
                withAnimation {
                    item.isCompleted.toggle()
                }
            } label: {
                Image(systemName: "checkmark")
                    .symbolVariant(.circle.fill)
                    .foregroundStyle(item.isCompleted ? .green : .gray)
                    .font(.largeTitle)
            }
            .buttonStyle(.plain)
        }
    }
    
    private func deleteActionButton(for item: ToDoItem) -> some View {
        Button(role: .destructive) {
            withAnimation {
                modelContext.delete(item)
            }
        } label: {
            Label("Delete", systemImage: "trash")
                .symbolVariant(.fill)
        }
    }
    
    private func editActionButton(for item: ToDoItem) -> some View {
        Button {
            toDoEditItem = item
        } label: {
            Label("Edit", systemImage: "pencil")
        }
        .tint(.orange)
    }

}

#Preview {
    ToDoListView()
        .modelContainer(for: ToDoItem.self, inMemory: true)
}
