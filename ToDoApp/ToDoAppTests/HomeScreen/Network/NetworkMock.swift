//
//  WeatherNetworkMock.swift
//  ToDoApp
//
//  Created by Marie Harmsen on 25/05/2025.
//

@testable import ToDoApp
import Foundation

class NetworkManagerMock<A: Decodable>: NetworkManagerProtocol {
    private var responseType: ResponseType
    private var type: A.Type
    
    init(responseType: ResponseType, type: A.Type) {
        self.responseType = responseType
        self.type = type
    }
    
    func fetchData<T: Decodable>(fileName: ToDoApp.FileName, type: T.Type, completion: @escaping (Result<T?, ToDoApp.NetworkError>) -> Void) {
        switch responseType {
        case .success:
            if type == AstronomyWeatherModel.self {
                return completion(.success(AstronomyWeatherModel(astronomy: Astronomy(astro: Astro(sunrise: "05:31 AM", sunset: "08:16 PM"))) as? T))
            } else if type == CurrentWeatherModel.self {
                return completion(.success(CurrentWeatherModel(current: Current(tempC: 11.1)) as? T))
            }
        case .failure:
            return completion(.failure(NetworkError.connectionError))
        }
    }
    
    func decodeData<T>(data: Data, as type: T.Type) -> T? {
        if type == AstronomyWeatherModel.self {
            return AstronomyWeatherModel(astronomy: Astronomy(astro: Astro(sunrise: "05:31 AM", sunset: "08:16 PM"))) as? T
        } else if type == CurrentWeatherModel.self {
            return CurrentWeatherModel(current: Current(tempC: 11.1)) as? T
        }
        return nil
    }
}
