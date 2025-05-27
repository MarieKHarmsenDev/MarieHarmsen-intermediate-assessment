//
//  AstronomyWeatherModel.swift
//  ToDoApp
//
//  Created by Marie Harmsen on 25/05/2025.
//

struct AstronomyWeatherModel: Equatable, Decodable {
    let astronomy: Astronomy
}

struct Astronomy: Equatable, Decodable {
    let astro: Astro
}

struct Astro: Equatable, Decodable {
    let sunrise: String
    let sunset: String
}
