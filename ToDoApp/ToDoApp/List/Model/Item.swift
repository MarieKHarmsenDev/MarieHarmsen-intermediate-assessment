//
//  ToDoItem.swift
//  ToDoApp
//
//  Created by Marie Harmsen on 25/05/2025.
//
import Foundation
import SwiftData

@Model
class Item: Identifiable {
    var id = UUID()
    var titleText: String
    var descriptionText: String
    var isCompleted: Bool
    
    init(titleText: String, descriptionText: String, isCompleted: Bool) {
        self.titleText = titleText
        self.descriptionText = descriptionText
        self.isCompleted = isCompleted
    }
}
