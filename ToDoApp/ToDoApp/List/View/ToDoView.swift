//
//  ToDoView.swift
//  ToDoApp
//
//  Created by Marie Harmsen on 25/05/2025.
//
import SwiftUI
import SwiftData

struct ToDoView: View {
    private let viewModel: ToDoViewModel

    init(viewModel: ToDoViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            List {
                Section(header: Regular(text: "listView.toDoHeading".localized)) {
                    ForEach(viewModel.toDoItems.filter { !$0.isCompleted }) { item in
                        createToDoRow(item: item)
                    }
                    .onDelete(perform: viewModel.deleteItem)
                }
                
                Section(header: Regular(text: "listView.completedHeading".localized)) {
                    ForEach(viewModel.toDoItems.filter { $0.isCompleted }) { item in
                        createToDoRow(item: item)
                    }
                    .onDelete(perform: viewModel.deleteItem)
                }
            }
            .listStyle(InsetGroupedListStyle())
        }
    }
    
    private func createToDoRow(item: ToDoItem) -> some View {
        Button(action: {
            viewModel.updateCompleteStatus(item: item)
        }) {
            VStack(spacing: 0) {
                HStack {
                    Image(systemName: item.isCompleted ? "checkmark.circle.fill" : "circle")
                        .foregroundColor(item.isCompleted ? .customSuccess : .accent)
                        .padding(.vertical, 16)
                    Regular(text: item.titleText)
                    Spacer()
                }
                HStack {
                    Small(text: item.descriptionText)
                    Spacer()
                }
            }
            .padding(.horizontal)
            .contentShape(Rectangle())
        }
        .buttonStyle(PlainButtonStyle())
    }
}
