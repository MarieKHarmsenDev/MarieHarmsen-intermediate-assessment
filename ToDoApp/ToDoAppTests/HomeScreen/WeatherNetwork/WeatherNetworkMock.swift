//
//  WeatherNetworkMock.swift
//  ToDoApp
//
//  Created by Marie Harmsen on 25/05/2025.
//

@testable import ToDoApp
import Foundation

class WeatherNetworkManagerMock: WeatherNetworkManagerProtocol {
    
    private var responseType: ResponseType
    
    init(responseType: ResponseType) {
        self.responseType = responseType
    }
    
    func fetchAstronomyWeatherData(completion: @escaping (Result<ToDoApp.AstronomyWeatherModel?, ToDoApp.NetworkError>) -> Void) {
        switch responseType {
        case .success:
            return completion(.success(AstronomyWeatherModel(astronomy: Astronomy(astro: Astro(sunrise: "05:31 AM", sunset: "08:16 PM")))))
        case .failure:
            return completion(.failure(NetworkError.connectionError))
        }
    }
    
    func fetchCurrentWeatherData(completion: @escaping (Result<ToDoApp.CurrentWeatherModel?, ToDoApp.NetworkError>) -> Void) {
        switch responseType {
        case .success:
            return completion(.success(CurrentWeatherModel(current: Current(tempC: 16.1))))
        case .failure:
            return completion(.failure(NetworkError.connectionError))
        }
    }
    
    func decodeAstronomyWeatherData(_ data: Data) -> ToDoApp.AstronomyWeatherModel? {
        return AstronomyWeatherModel(astronomy: Astronomy(astro: Astro(sunrise: "05:31 AM", sunset: "08:16 PM")))
    }
    
    func decodeCurrentWeatherData(_ data: Data) -> ToDoApp.CurrentWeatherModel? {
        return CurrentWeatherModel(current: Current(tempC: 16.1))
    }
}
