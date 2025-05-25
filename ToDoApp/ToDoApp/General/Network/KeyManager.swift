//
//  KeyManager.swift
//  ToDoApp
//
//  Created by Marie Harmsen on 25/05/2025.
//

class KeyManager {
    static var shared = KeyManager()
    
    private init() {}
    
    private var apiKey: String = "0960eZZ0d543bZ74483bZ30Z211223Z2Z5240Z5"
    
    func getAPIKey() -> String {
        // A better approach would be to get the API key from a backend service, such as Firebase, have the APIKey be sent with salt and then decode it in the app. Since this API key is free and not linked to a card I haven't implemented this, but would be done before leading to production. Impleneted a basic "remove salt" function to explain how it works, but would use a library for something better here.
        removeSalt(key: apiKey, letter: "Z")
    }
    
    private func removeSalt(key: String, letter: String) -> String {
        key.replacingOccurrences(of: letter, with: "")
    }
}
