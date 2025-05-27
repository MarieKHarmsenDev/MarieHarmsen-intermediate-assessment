//
//  WeatherViewModelTests.swift
//  ToDoApp
//
//  Created by Marie Harmsen on 27/05/2025.
//

import XCTest
@testable import ToDoApp

class WeatherViewModelTests: XCTestCase {
    
    var sut: WeatherViewModel!
        
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        sut = nil
    }
    
    func test_fetchCurrentWeatherData_success() {
        let networkMock = NetworkManagerMock(responseType: .success, type: CurrentWeatherModel.self)
        sut = WeatherViewModel(network: networkMock)
        let expectation = XCTestExpectation(description: "Wait for published variable to be set")

        sut.fetchCurrentWeatherData()

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
            XCTAssertEqual(self?.sut.currentTempreature, "11.1°C")
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1.0)
    }
    
    func test_fetchCurrentWeatherData_failure() {
        let networkMock = NetworkManagerMock(responseType: .failure, type: CurrentWeatherModel.self)
        sut = WeatherViewModel(network: networkMock)
        let expectation = XCTestExpectation(description: "Wait for published variable to be set")

        sut.fetchCurrentWeatherData()

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
            XCTAssertNil(self?.sut.currentTempreature)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1.0)
    }
    
    func test_fetchAstronomyWeatherData_success() {
        let networkMock = NetworkManagerMock(responseType: .success, type: AstronomyWeatherModel.self)
        sut = WeatherViewModel(network: networkMock)
        let expectation = XCTestExpectation(description: "Wait for published variable to be set")

        sut.fetchCurrentWeatherData()

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
            XCTAssertEqual(self?.sut.sunset, "08:16 PM")
            XCTAssertEqual(self?.sut.sunrise, "05:31 AM")
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1.0)
    }
    
    func test_fetchAstronomyWeatherData_failure() {
        let networkMock = NetworkManagerMock(responseType: .failure, type: AstronomyWeatherModel.self)
        sut = WeatherViewModel(network: networkMock)
        let expectation = XCTestExpectation(description: "Wait for published variable to be set")

        sut.fetchCurrentWeatherData()

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
            XCTAssertNil(self?.sut.sunset)
            XCTAssertNil(self?.sut.sunrise)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1.0)
    }
    
    func test_fetchCurrentWeatherDataSuccesss_fetchAstronomyWeatherDataFailure() {
        let networkMock = NetworkManagerMock(responseType: .success, type: CurrentWeatherModel.self)
        sut = WeatherViewModel(network: networkMock)
        let expectation = XCTestExpectation(description: "Wait for published variable to be set")
        
        let networkMockTwo = NetworkManagerMock(responseType: .failure, type: AstronomyWeatherModel.self)
        sut = WeatherViewModel(network: networkMockTwo)

        sut.fetchCurrentWeatherData()
        sut.fetchAstronomyWeatherData()

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
            XCTAssertNil(self?.sut.currentTempreature)
            XCTAssertNil(self?.sut.sunset)
            XCTAssertNil(self?.sut.sunrise)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1.0)
    }

}
