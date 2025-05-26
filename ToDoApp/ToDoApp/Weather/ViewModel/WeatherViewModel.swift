//
//  WeatherViewModel.swift
//  ToDoApp
//
//  Created by Marie Harmsen on 25/05/2025.
//
import SwiftUI
import Foundation

class WeatherViewModel: ObservableObject {
    private var network: WeatherNetworkManagerProtocol
    private let logger = Logger()
    
    @Published var currentTempreature: String?
    @Published var sunrise: String?
    @Published var sunset: String?

    init(network: WeatherNetworkManagerProtocol) {
        self.network = network
        fetchWeatherData()
    }
    
    func fetchWeatherData() {
        network.fetchAstronomyWeatherData() { [weak self] result in
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
        
        network.fetchCurrentWeatherData() { [weak self] result in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self?.currentTempreature = String(response?.current.tempC ?? 0)
                }
            case .failure(let error):
                self?.logger.logError("fetch current weather data failed with error: \(error)")
            }
        }
    }
}
