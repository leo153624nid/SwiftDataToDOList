//
//  ToDoListView.swift
//  SwiftDataToDoList
//
//  Created by A Ch on 07.06.2024.
//

import SwiftUI

struct ToDoListView: View {
    
    @State private var viewModel = ToDoListViewModel()

    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.items) { item in
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
                
                if !viewModel.items.isEmpty {
                    toolBarEditItem
                }
            }
        }
        .sheet(isPresented: $viewModel.showCreateToDoView) {
            NavigationStack {
                CreateToDoView()
            }
            .presentationDetents([.medium])
        }
        .sheet(item: $viewModel.toDoEditItem) {
            // on dismiss
            viewModel.perform(action: .showUpdateToDoView(item: nil))
        } content: { item in
            UpdateToDoView(item: item)
        }

    }
    
    private var toolBarCreateItem: some ToolbarContent {
        ToolbarItem {
            Button {
                viewModel.perform(action: .showCreateToDoView)
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
                    // TODO: in viewModel
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
                // TODO: - in viewModel
//                modelContext.delete(item)
            }
        } label: {
            Label("Delete", systemImage: "trash")
                .symbolVariant(.fill)
        }
    }
    
    private func editActionButton(for item: ToDoItem) -> some View {
        Button {
            viewModel.perform(action: .showUpdateToDoView(item: item))
        } label: {
            Label("Edit", systemImage: "pencil")
        }
        .tint(.orange)
    }

}

#Preview {
    ToDoListView()
}
