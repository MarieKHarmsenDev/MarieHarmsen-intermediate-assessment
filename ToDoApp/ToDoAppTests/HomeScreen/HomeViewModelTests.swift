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
    private let expectation = XCTestExpectation(description: "Wait for published variable to be set")
    private let locationManagerMock = LocationManagerMock()
    
    var sut: HomeViewModel!
        
    override func setUp() {
        sut = HomeViewModel(locationManager: locationManagerMock)
        super.setUp()
    }
    
    override func tearDown() {
        sut = nil
    }
    
    func test_didUpdateLocation_UserError() {
        XCTAssertEqual(sut.flowState, .loading)
        sut.lat = nil
        sut.long = nil

        locationManagerMock.delegate?.didUpdateLocation(latitude: nil, longitude: nil, error: .userPermission)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
            guard let self = self else {
                XCTFail("Self should not fail")
                return
            }
            XCTAssertTrue(self.sut.shouldShowAlert)
            XCTAssertEqual(self.sut.flowState, .loading)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1.0)
    }
    
    func test_didUpdateLocation_locationError() {
        XCTAssertEqual(sut.flowState, .loading)
        sut.lat = nil
        sut.long = nil

        locationManagerMock.delegate?.didUpdateLocation(latitude: nil, longitude: nil, error: .locationError)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
            guard let self = self else {
                XCTFail("Self should not fail")
                return
            }
            XCTAssertFalse(self.sut.shouldShowAlert)
            XCTAssertEqual(self.sut.flowState, .error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
    }
    
    func test_didUpdateLocation_success() {
        XCTAssertEqual(sut.flowState, .loading)

        locationManagerMock.delegate?.didUpdateLocation(latitude: 11.1, longitude: 11.1, error: nil)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
            guard let self = self else {
                XCTFail("Self should not fail")
                return
            }
            XCTAssertEqual(sut.flowState, .success)
            XCTAssertNotNil(sut.lat)
            XCTAssertNotNil(sut.long)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
    }
}
