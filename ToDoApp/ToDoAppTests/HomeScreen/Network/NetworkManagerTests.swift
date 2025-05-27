//
//  NetworkManagerTests.swift
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

class NetworkManagerTests: XCTestCase {
    
    var sut: NetworkManager!
    private var fileReader = FileReader()
        
    override func setUp() {
        sut = NetworkManager(latitude: "100.5", longitude: "510.5")
    }
    
    override func tearDown() {
        sut = nil
    }
    
    // MARK: CurrentWeather
    
    func test_invalidURL() {
        let sut = NetworkManager(latitude: "", longitude: "51.5")
        sut.lat = nil
        
        sut.fetchData(fileName: .current, type: CurrentWeatherModel.self) { result in
            switch result {
            case .success(_):
                XCTFail("This should fail due to lat being nil")
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
        let result = sut.decodeData(data: data, as: CurrentWeatherModel.self)
        XCTAssertEqual(result, expectedResult)
    }
    
    func testDecodeCurrentWeatherData_dataIssue() {
        guard let data = fileReader.readJSONFile(fileName: "CurrentDataIssue") else {
            XCTFail("File issue")
            return
        }
        let result = sut.decodeData(data: data, as: CurrentWeatherModel.self)
        XCTAssertNil(result)
    }
    
    // MARK: AstronomyWeather
    
    func testDecodeAstronomyWeatherData() {
        guard let data = fileReader.readJSONFile(fileName: "Astronomy") else {
            XCTFail("File issue")
            return
        }
        let expectedResult = AstronomyWeatherModel(astronomy: Astronomy(astro: Astro(sunrise: "05:31 AM", sunset: "08:16 PM")))
        let result = sut.decodeData(data: data, as: AstronomyWeatherModel.self)
        XCTAssertEqual(result, expectedResult)
    }
    
    func testDecodeAstronomyWeatherData_dataIssue() {
        guard let data = fileReader.readJSONFile(fileName: "AstronomyDataIssue") else {
            XCTFail("File issue")
            return
        }
        let result = sut.decodeData(data: data, as: AstronomyWeatherModel.self)
        XCTAssertNil(result)
    }
}
