//
//  CurrentWeatherModel.swift
//  ToDoApp
//
//  Created by Marie Harmsen on 25/05/2025.
//

struct CurrentWeatherModel: Codable {
    let current: Current
}

struct Current: Codable {
    let tempC: Double
}
