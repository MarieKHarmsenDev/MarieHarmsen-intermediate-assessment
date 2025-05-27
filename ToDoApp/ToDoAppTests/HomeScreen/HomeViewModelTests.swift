//
//  HomeViewModelTests.swift
//  ToDoApp
//
//  Created by Marie Harmsen on 25/05/2025.
//

import XCTest
@testable import ToDoApp

class HomeViewModelTests: XCTestCase {
    var networkMock: NetworkManagerMock<CurrentWeatherModel>!
    
    var sut: HomeViewModel!
        
    override func setUp() {
        super.setUp()
        sut = HomeViewModel(locationManager: LocationManager())
    }
    
    override func tearDown() {
        sut = nil
    }
    
    func test_didUpdateLocation_UserError() {
        sut.flowState = .loading

        sut.didUpdateLocation(latitude: 5.5, longitude: 1.1, error: .userPermission)
        sut.flowState = .loading
        XCTAssertTrue(sut.shouldShowAlert)
    }
    
    func test_didUpdateLocation_locationManagerError() {
        sut.flowState = .loading

        sut.didUpdateLocation(latitude: 5.5, longitude: 1.1, error: .locationManagerError)
        sut.flowState = .error
        XCTAssertFalse(sut.shouldShowAlert)
    }
    
    func test_didUpdateLocation_locationError() {
        sut.flowState = .loading

        sut.didUpdateLocation(latitude: 5.5, longitude: 1.1, error: .locationError)
        sut.flowState = .error
        XCTAssertFalse(sut.shouldShowAlert)
    }
    
    func test_didUpdateLocation_success() {
        sut.flowState = .loading

        sut.didUpdateLocation(latitude: 5.5, longitude: 1.1, error: nil)
        sut.flowState = .success
        XCTAssertFalse(sut.shouldShowAlert)
        XCTAssertNotNil(sut.lat)
        XCTAssertNotNil(sut.long)
    }
}
