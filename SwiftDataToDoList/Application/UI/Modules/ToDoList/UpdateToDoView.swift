//
//  UpdateToDoView.swift
//  SwiftDataToDoList
//
//  Created by A Ch on 30.06.2024.
//

import SwiftUI
import SwiftData

struct UpdateToDoView: View {
    // TODO: update item only on tapping "Update" button
    
    @Environment(\.dismiss) private var dismiss
    
    @Bindable var item: ToDoItem
    
    var body: some View {
        List {
            TextField("Name", text: $item.title)
            DatePicker("Choose a date",
                       selection: $item.timestamp)
            Toggle("Is important?", isOn: $item.isCritical)
            Button("Udate") {
                dismiss()
            }
        }
        .navigationTitle("Update ToDo")
    }
}

#Preview {
    UpdateToDoView(item: ToDoItem(title: "test1", 
                                  timestamp: .now,
                                  isCritical: true,
                                  isCompleted: true))
}
