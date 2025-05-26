//
//  ToDoItem.swift
//  ToDoApp
//
//  Created by Marie Harmsen on 25/05/2025.
//
import Foundation
import SwiftData

@Model
class ToDoItem: Identifiable {
    var id = UUID()
    var titleText: String
    var descriptionText: String
    var isCompleted: Bool
    
    init(id: UUID = UUID(), titleText: String, descriptionText: String, isCompleted: Bool) {
        self.id = id
        self.titleText = titleText
        self.descriptionText = descriptionText
        self.isCompleted = isCompleted
    }
}
