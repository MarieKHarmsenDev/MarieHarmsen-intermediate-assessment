//
//  ToDoViewModel.swift
//  ToDoApp
//
//  Created by Marie Harmsen on 25/05/2025.
//

import SwiftUI
import Foundation
import CoreLocation
import SwiftData

@Observable
class ToDoViewModel {
    private let modelContext: ModelContext
    var toDoItems: [ToDoItem] = []
    let logger = Logger()

    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        fetchItems()
    }

    func fetchItems() {
        do {
            let descriptor = FetchDescriptor<ToDoItem>()
            self.toDoItems = try modelContext.fetch(descriptor)
        } catch {
            logger.logError("Failed to fetch todo items")
        }
    }

    func addItem(titleText: String, descriptionText: String) {
        let item = ToDoItem(titleText: titleText, descriptionText: descriptionText, isCompleted: false)
        modelContext.insert(item)
        saveItem()
    }
    
    func deleteItem(at offsets: IndexSet) {
        for index in offsets {
            let item = toDoItems[index]
            modelContext.delete(item)
        }
        saveItem()
    }
    
    private func saveItem() {
        do {
            try modelContext.save()
            fetchItems()
        } catch {
            logger.logError("Failed to save todo items")
        }
    }
    
    func updateCompleteStatus(item: ToDoItem) {
        item.isCompleted.toggle()
        saveItem()
    }
}
