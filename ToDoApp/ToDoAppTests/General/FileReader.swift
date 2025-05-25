//
//  FileReader.swift
//  ToDoApp
//
//  Created by Marie Harmsen on 25/05/2025.
//

import Testing
import ToDoApp
import UIKit
import XCTest
import SwiftUI
@testable import ToDoApp

class FileReader: XCTestCase {
    
    func readJSONFile(fileName: String) -> Data? {
        guard let url = Bundle(for: type(of: self)).url(forResource: fileName, withExtension: "json") else {
            XCTFail("Can't read JSON file")
            return nil
        }
        do {
            return try Data(contentsOf: url)
        }
        catch {
            XCTFail("Can't read JSON file")
        }
        return nil
    }
}
