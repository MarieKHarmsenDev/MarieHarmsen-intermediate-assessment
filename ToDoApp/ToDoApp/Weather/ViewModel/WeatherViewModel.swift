//
//  WeatherViewModel.swift
//  ToDoApp
//
//  Created by Marie Harmsen on 25/05/2025.
//
import SwiftUI
import Foundation

class WeatherViewModel: ObservableObject {
    private var network: NetworkManagerProtocol
    private let logger = Logger()
    
    @Published var currentTempreature: String?
    @Published var sunrise: String?
    @Published var sunset: String?

    init(network: NetworkManagerProtocol) {
        self.network = network
        fetchCurrentWeatherData()
        fetchAstronomyWeatherData()
    }
    
    func fetchCurrentWeatherData() {
        network.fetchData(fileName: .current, type: CurrentWeatherModel.self) { [weak self] result in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    let stringTemp = String(response?.current.tempC ?? 0)
                    self?.currentTempreature = stringTemp + "°C"
                }
            case .failure(let error):
                self?.logger.logError("fetch current weather data failed with error: \(error)")
            }
        }
    }
    
    func fetchAstronomyWeatherData() {
        network.fetchData(fileName: .astronomy, type: AstronomyWeatherModel.self) { [weak self] result in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self?.sunrise = response?.astronomy.astro.sunrise
                    self?.sunset = response?.astronomy.astro.sunset
                }
            case .failure(let error):
                self?.logger.logError("fetch astronomy weather data failed with error: \(error)")
            }
        }
    }
}
