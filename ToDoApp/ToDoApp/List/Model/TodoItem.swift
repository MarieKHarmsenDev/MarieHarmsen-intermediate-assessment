//
//  toDoItem.swift
//  ToDoApp
//
//  Created by Marie Harmsen on 25/05/2025.
//
import Foundation

struct TodoItem: Identifiable {
    let id = UUID()
    let title: String
    let description: String
    var isCompleted: Bool
}
