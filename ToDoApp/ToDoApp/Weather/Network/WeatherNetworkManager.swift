//
//  NetworkManager.swift
//  ToDoApp
//
//  Created by Marie Harmsen on 25/05/2025.
//

import Foundation

enum FileName {
    case astronomy
    case current
}

protocol WeatherNetworkManagerProtocol {
    func fetchAstronomyWeatherData(completion: @escaping(Result<AstronomyWeatherModel?, NetworkError>) -> Void)
    func decodeAstronomyWeatherData(_ data: Data) -> AstronomyWeatherModel?
    func fetchCurrentWeatherData(completion: @escaping(Result<CurrentWeatherModel?, NetworkError>) -> Void)
    func decodeCurrentWeatherData(_ data: Data) -> CurrentWeatherModel?
}

class WeatherNetworkManager: WeatherNetworkManagerProtocol {
    
    private let networkLogger = NetworkLogger()
    private let locationManager = LocationManager()
    private let decoder = JSONDecoder()
    
    private var lat: String? = nil
    private var long: String? = nil
    
    init(latitude: String, longitude: String) {
        self.lat = latitude
        self.long = longitude
    }
    
    private func createURL(fileName: FileName) -> URL? {
        let apiKey = KeyManager.shared.getAPIKey()
        let urlBaseString = "https://api.weatherapi.com/v1/\(fileName).json?"
        guard let lat = lat, let long = long else { return nil }
        return URL(string: "\(urlBaseString)key=\(apiKey)&q=\(String(lat)),\(String(long))")
    }
}

// MARK: AstronomyWeather

extension WeatherNetworkManager {
    
    func fetchAstronomyWeatherData(completion: @escaping(Result<AstronomyWeatherModel?, NetworkError>) -> Void) {
        guard let url = createURL(fileName: .astronomy) else {
            completion(.failure(.invalidURL))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            if let data = data, let decodedData = self?.decodeAstronomyWeatherData(data) {
                completion(.success(decodedData))
            } else {
                completion(.failure(.dataIssue))
            }
        }
        task.resume()
    }
    
    func decodeAstronomyWeatherData(_ data: Data) -> AstronomyWeatherModel? {
        do {
            let decodeData = try decoder.decode(AstronomyWeatherModel.self, from: data)
            return decodeData
        } catch {
            networkLogger.logError("Failed to decode astronomy weather")
            return nil
        }
    }
}

// MARK: CurrentWeather

extension WeatherNetworkManager {
    
    func fetchCurrentWeatherData(completion: @escaping(Result<CurrentWeatherModel?, NetworkError>) -> Void) {
        guard let url = createURL(fileName: .current) else {
            completion(.failure(.invalidURL))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            if let data = data, let decodedData = self?.decodeCurrentWeatherData(data) {
                completion(.success(decodedData))
            } else {
                completion(.failure(.dataIssue))
            }
        }
        task.resume()
    }
    
    func decodeCurrentWeatherData(_ data: Data) -> CurrentWeatherModel? {
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        do {
            let decodeData = try decoder.decode(CurrentWeatherModel.self, from: data)
            return decodeData
        } catch {
            networkLogger.logError("Failed to decode current weather")
            return nil
        }
    }
}
