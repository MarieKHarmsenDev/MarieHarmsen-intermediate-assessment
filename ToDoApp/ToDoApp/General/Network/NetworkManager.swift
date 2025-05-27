//
//  NetworkManager.swift
//  ToDoApp
//
//  Created by Marie Harmsen on 26/05/2025.
//

import Foundation

enum FileName {
    case astronomy
    case current
}

enum NetworkError: Error {
    case connectionError
    case dataIssue
    case decodeDataIssue
    case invalidURL
}

protocol NetworkManagerProtocol {
    func fetchData<T: Decodable>(fileName: FileName, type: T.Type, completion: @escaping(Result<T?, NetworkError>) -> Void)
    func decodeData<T: Decodable>(data: Data, as type: T.Type) -> T?
}

class NetworkManager: NetworkManagerProtocol {
    var lat: String? = nil
    var long: String? = nil
    
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
    
    func fetchData<T: Decodable>(fileName: FileName, type: T.Type, completion: @escaping(Result<T?, NetworkError>) -> Void) {
        guard let url = createURL(fileName: fileName) else {
            completion(.failure(.invalidURL))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard error == nil else {
                completion(.failure(.connectionError))
                return
            }
            guard let data = data else {
                completion(.failure(.dataIssue))
                return
            }
            if let decodedData = self?.decodeData(data: data, as: type)  {
                completion(.success(decodedData))
            } else {
                completion(.failure(.decodeDataIssue))
            }
        }
        task.resume()
    }
    
    func decodeData<T: Decodable>(data: Data, as type: T.Type) -> T? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        do {
            let decodeData = try decoder.decode(T.self, from: data)
            return decodeData
        } catch {
            return nil
        }
    }
}
