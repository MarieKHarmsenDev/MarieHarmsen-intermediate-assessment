//
//  CurrentWeatherModel.swift
//  ToDoApp
//
//  Created by Marie Harmsen on 25/05/2025.
//

struct AstronomyWeatherModel: Equatable, Codable {
    let astronomy: Astronomy
}

struct Astronomy: Equatable, Codable {
    let astro: Astro
}

struct Astro: Equatable, Codable {
    let sunrise: String
    let sunset: String
}
