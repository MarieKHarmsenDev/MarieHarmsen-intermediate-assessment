//
//  LocationManagerMock.swift
//  ToDoApp
//
//  Created by Marie Harmsen on 28/05/2025.
//

import XCTest
@testable import ToDoApp
import Foundation

class LocationManagerMock: LocationMnagerProtocol {
    var delegate: (any ToDoApp.LocationManagerDelegate)?
    
    func handleLocationAuthorised() {
        
    }
    
    
}

