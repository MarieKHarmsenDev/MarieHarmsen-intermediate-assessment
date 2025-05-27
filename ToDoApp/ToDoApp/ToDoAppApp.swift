//
//  ToDoAppApp.swift
//  ToDoApp
//
//  Created by Marie Harmsen on 24/05/2025.
//

import SwiftUI
import SwiftData

@main
struct ToDoAppApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView()
        }
        .modelContainer(for: Item.self)
    }
}
