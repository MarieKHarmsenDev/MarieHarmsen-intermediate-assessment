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
}
