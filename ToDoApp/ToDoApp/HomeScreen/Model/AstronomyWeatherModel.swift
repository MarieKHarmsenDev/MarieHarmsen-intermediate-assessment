//
//  CurrentWeatherModel.swift
//  ToDoApp
//
//  Created by Marie Harmsen on 25/05/2025.
//

struct AstronomyWeatherModel: Codable {
    let astronomy: Astronomy
}

struct Astronomy: Codable {
    let astro: Astro
}

struct Astro: Codable {
    let sunrise: String
    let sunset: String
}
