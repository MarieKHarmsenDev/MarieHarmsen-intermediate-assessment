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
    var allItems: [Item] = []

    var toDoItems: [Item] {
        allItems.filter { !$0.isCompleted }
    }
    var completedItems: [Item] {
        allItems.filter { $0.isCompleted }
    }
    let logger = Logger()

    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        fetchItems()
    }

    func fetchItems() {
        do {
            let descriptor = FetchDescriptor<Item>()
            self.allItems = try modelContext.fetch(descriptor)
        } catch {
            logger.logError("Failed to fetch todo items")
        }
    }

    func addItem(titleText: String, descriptionText: String) {
        let item = Item(titleText: titleText, descriptionText: descriptionText, isCompleted: false)
        modelContext.insert(item)
        saveItem()
    }
    
    func deleteItem(item: Item) {
        modelContext.delete(item)
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
    
    func updateCompleteStatus(item: Item) {
        item.isCompleted = !item.isCompleted
        saveItem()
    }
}
