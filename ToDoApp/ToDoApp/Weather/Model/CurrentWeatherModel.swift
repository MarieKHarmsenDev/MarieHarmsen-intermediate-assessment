//
//  CurrentWeatherModel.swift
//  ToDoApp
//
//  Created by Marie Harmsen on 25/05/2025.
//

struct CurrentWeatherModel: Equatable, Codable {
    let current: Current
}

struct Current: Equatable, Codable {
    let tempC: Double
}
