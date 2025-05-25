//
//  HomeViewModel.swift
//  ToDoApp
//
//  Created by Marie Harmsen on 25/05/2025.
//

import SwiftUI
import Foundation
import CoreLocation

class HomeViewModel: ObservableObject, LocationManagerDelegate {
    private let locationManager: LocationManager
    private var network: WeatherNetworkManagerProtocol?
    @Published var shouldShowAlert: Bool = false
    @Published var flowState: FlowState = .loading
    
    var currentWeather: CurrentWeatherModel?
    var astronomyWeather: AstronomyWeatherModel?

    init(locationManager: LocationManager) {
        self.locationManager = locationManager
        locationManager.delegate = self
    }

    func didUpdateLocation(latitude: Double?, longitude: Double?, error: LocationError?) {
        if let error = error {
            switch error {
            case .locationManagerError, .locationError:
                updateFlowState(state: .error)
            case .userPermission:
                shouldShowAlert = true
            }
            return
        }
        guard let lat = latitude, let long = longitude else {
            return
        }
        network = WeatherNetworkManager(latitude: String(lat), longitude: String(long))
        fetchWeatherData()
    }
    
    private func updateFlowState(state: FlowState) {
        DispatchQueue.main.async { [weak self] in
            self?.flowState = state
        }
    }
    
    func fetchWeatherData() {
        let group = DispatchGroup()

        group.enter()
        network?.fetchAstronomyWeatherData() { [weak self] result in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self?.astronomyWeather = response
                }
            case .failure:
                self?.updateFlowState(state: .error)
            }
            group.leave()
        }
        
        group.enter()
        network?.fetchCurrentWeatherData() { [weak self] result in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self?.currentWeather = response
                }
            case .failure:
                self?.updateFlowState(state: .error)
            }
            group.leave()
        }
        
        group.notify(queue: .main) { [weak self] in
            self?.updateFlowState(state: .success)
        }
    }
    
    var sunset: String {
        return astronomyWeather?.astronomy.astro.sunset ?? ""
    }
    
    var sunrise: String {
        return astronomyWeather?.astronomy.astro.sunrise ?? ""
    }
    
    var currentTempreature: String {
        guard let temp = currentWeather?.current.tempC else { return "" }
        return String(temp)
    }
}
