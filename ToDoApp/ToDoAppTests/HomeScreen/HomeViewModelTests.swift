//
//  HomeViewModelTests.swift
//  ToDoApp
//
//  Created by Marie Harmsen on 25/05/2025.
//

import XCTest
@testable import ToDoApp

class HomeViewModelTests: XCTestCase {
    var viewModel: HomeViewModel!
    var networkMock: WeatherNetworkManagerMock!
    
    var sut: HomeViewModel!
        
    override func setUp() {
        super.setUp()
        sut = HomeViewModel(locationManager: LocationManager())
    }
    
    override func tearDown() {
        sut = nil
    }
}
