//
//  WeatherNetworkManagerTests.swift
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

class WeatherNetworkManagerTests: XCTestCase {
    
    var sut: WeatherNetworkManager!
    private var fileReader = FileReader()
        
    override func setUp() {
        sut = WeatherNetworkManager(latitude: "10.5", longitude: "51.5")
    }
    
    override func tearDown() {
        sut = nil
    }
    
    // MARK: CurrentWeather
    
    func testfetchCurrentWeatherData_invalidURL() {
        let sut = WeatherNetworkManager(latitude: "<>", longitude: "51.5")
        
        sut.fetchCurrentWeatherData() { result in
            switch result {
            case .success(_):
                XCTFail("This should fail due to invalid characters in URL")
            case .failure(let error):
                XCTAssertEqual(error, .invalidURL)
            }
        }
    }
    
    func testDecodeCurrentWeatherData() {
        guard let data = fileReader.readJSONFile(fileName: "Current") else {
            XCTFail("File issue")
            return
        }
        let expectedResult = CurrentWeatherModel(current: Current(tempC: 16.1))
        let result = sut.decodeCurrentWeatherData(data)
        XCTAssertEqual(result, expectedResult)
    }
    
    func testDecodeCurrentWeatherData_dataIssue() {
        guard let _ = fileReader.readJSONFile(fileName: "CurrentDataIssue") else {
            XCTFail("File issue")
            return
        }
        sut.fetchAstronomyWeatherData() { result in
            switch result {
            case .success(_):
                XCTFail("This should fail due to invalid name in file")
            case .failure(let error):
                XCTAssertEqual(error, .dataIssue)
            }
        }
    }
    
    // MARK: AstronomyWeather
    
    func testfetchAstonomyWeatherData_invalidURL() {
        let sut = WeatherNetworkManager(latitude: "<>", longitude: "51.5")
        
        sut.fetchAstronomyWeatherData() { result in
            switch result {
            case .success(_):
                XCTFail("This should fail due to invalid characters in URL")
            case .failure(let error):
                XCTAssertEqual(error, .invalidURL)
            }
        }
    }
    
    func testDecodeAstronomyWeatherData() {
        guard let data = fileReader.readJSONFile(fileName: "Astronomy") else {
            XCTFail("File issue")
            return
        }
        let expectedResult = AstronomyWeatherModel(astronomy: Astronomy(astro: Astro(sunrise: "05:31 AM", sunset: "08:16 PM")))
        let result = sut.decodeAstronomyWeatherData(data)
        XCTAssertEqual(result, expectedResult)
    }
    
    func testDecodeAstronomyWeatherData_dataIssue() {
        guard let _ = fileReader.readJSONFile(fileName: "AstronomyDataIssue") else {
            XCTFail("File issue")
            return
        }
        sut.fetchAstronomyWeatherData() { result in
            switch result {
            case .success(_):
                XCTFail("This should fail due to invalid name in file")
            case .failure(let error):
                XCTAssertEqual(error, .dataIssue)
            }
        }
    }
}
