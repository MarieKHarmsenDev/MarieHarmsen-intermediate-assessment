//
//  ToDoView.swift
//  ToDoApp
//
//  Created by Marie Harmsen on 25/05/2025.
//

import SwiftUI

struct ToDoView: View {
    private let viewModel: ToDoViewModel

    init(viewModel: ToDoViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            List {
                createSection(header: "listView.toDoHeading".localized, items: viewModel.toDoItems)
                createSection(header: "listView.completedHeading".localized, items: viewModel.completedItems)
            }
            .listStyle(InsetGroupedListStyle())
        }
    }
    
    private func createSection(header: String, items: [Item]) -> some View {
        Section(header: Regular(text: header)) {
            ForEach(items) { item in
                createToDoRow(item: item)
            }
            .onDelete { indexSet in
                for index in indexSet {
                    let item = items[index]
                    viewModel.deleteItem(item: item)
                }
            }
        }
    }
    
    private func createToDoRow(item: Item) -> some View {
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
