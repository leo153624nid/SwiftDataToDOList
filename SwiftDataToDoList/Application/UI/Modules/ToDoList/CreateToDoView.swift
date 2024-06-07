//
//  CreateToDoView.swift
//  SwiftDataToDoList
//
//  Created by A Ch on 07.06.2024.
//

import SwiftUI

struct CreateToDoView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        List {
            TextField("Name", text: .constant(""))
            DatePicker("Choose a date",
                       selection: .constant(.now))
            Toggle("Is important?", isOn: .constant(false))
            Button("Create") {
                dismiss()
            }
        }
        .navigationTitle("Create ToDo")
    }
}

#Preview {
    CreateToDoView()
}
