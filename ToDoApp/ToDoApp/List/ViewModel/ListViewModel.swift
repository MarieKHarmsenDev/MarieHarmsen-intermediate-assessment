//
//  ListViewModel.swift
//  ToDoApp
//
//  Created by Marie Harmsen on 25/05/2025.
//

import SwiftUI
import Foundation
import CoreLocation

class ListViewModel: ObservableObject {
    
    @Published var items = [
        TodoItem(title: "Get nails done", description: "123 London Road at 13:00", isCompleted: false),
        TodoItem(title: "Get eyebrows donw", description: "44 Woking Street at 15:00", isCompleted: true)
    ]
    
    func updateCompleteStatus(item: TodoItem) {
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            items[index].isCompleted = !items[index].isCompleted
        }
    }
}
