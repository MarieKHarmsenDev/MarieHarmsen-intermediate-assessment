//
//  String+Extension.swift
//  ToDoApp
//
//  Created by Marie Harmsen on 25/05/2025.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    
    var removeStartingZero: String {
        if self.hasPrefix("0") {
            let value = self.dropFirst()
            return String(value)
        }
        return self
    }
}
