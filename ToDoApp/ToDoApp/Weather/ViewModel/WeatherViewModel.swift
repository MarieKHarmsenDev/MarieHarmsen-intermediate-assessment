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
    
    @Published var currentTempreature: String = "No data"
    @Published var sunrise: String  = "No data"
    @Published var sunset: String  = "No data"

    init(network: WeatherNetworkManagerProtocol) {
        self.network = network
        fetchWeatherData()
    }
    
    func fetchWeatherData() {
        network.fetchAstronomyWeatherData() { [weak self] result in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self?.sunrise = response?.astronomy.astro.sunrise ?? "No data"
                    self?.sunset = response?.astronomy.astro.sunset ?? "No data"
                }
            case .failure:
                print("")
            }
        }
        
        network.fetchCurrentWeatherData() { [weak self] result in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self?.currentTempreature = String(response?.current.tempC ?? 0)
                }
            case .failure:
                print("")
            }
        }
    }
}
