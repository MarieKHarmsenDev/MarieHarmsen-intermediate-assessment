//
//  CurrentWeatherModel.swift
//  ToDoApp
//
//  Created by Marie Harmsen on 25/05/2025.
//

struct CurrentWeatherModel: Equatable, Decodable {
    let current: Current
}

struct Current: Equatable, Decodable {
    let tempC: Double
}
