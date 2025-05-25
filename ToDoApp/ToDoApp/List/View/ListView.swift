//
//  ListView.swift
//  ToDoApp
//
//  Created by Marie Harmsen on 25/05/2025.
//
import SwiftUI

struct ListView: View {
    @StateObject private var viewModel = ListViewModel()
    
    var body: some View {
        VStack {
            List {
                Section(header: Regular(text: "listView.toDoHeading".localized)) {
                    ForEach(viewModel.items.filter { !$0.isCompleted }) { item in
                        createRow(item: item)
                    }
                }
                
                Section(header: Regular(text: "listView.completedHeading".localized)) {
                    ForEach(viewModel.items.filter { $0.isCompleted }) { item in
                        createRow(item: item)
                    }
                }
            }
            .listStyle(InsetGroupedListStyle())
        }
    }
    
    private func createRow(item: TodoItem) -> some View {
        Button(action: {
            viewModel.updateCompleteStatus(item: item)
        }) {
            VStack(spacing: 0) {
                HStack {
                    Image(systemName: item.isCompleted ? "checkmark.circle.fill" : "circle")
                        .foregroundColor(item.isCompleted ? .customSuccess : .accent)
                        .padding(.vertical, 16)
                    Regular(text: item.title)
                    Spacer()
                }
                HStack {
                    Small(text: item.description)
                    Spacer()
                }
            }
            .padding(.horizontal)
            .contentShape(Rectangle())
        }
        .buttonStyle(PlainButtonStyle())
    }
}
