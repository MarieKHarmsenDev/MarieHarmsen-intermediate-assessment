//
//  WeatherView.swift
//  ToDoApp
//
//  Created by Marie Harmsen on 25/05/2025.
//
import SwiftUI
import Foundation

struct WeatherView: View {
    @StateObject var viewModel: WeatherViewModel

    var body: some View {
        VStack {
            HStack {
                createWeatherView(systemName: "thermometer.sun", value: viewModel.currentTempreature)
                createWeatherView(systemName: "sunrise", value: viewModel.sunrise)
                createWeatherView(systemName: "sunset", value: viewModel.sunset)
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color(.customBackground))
                    .shadow(radius: 2)
            )
            .padding(.horizontal, 16)
        }
    }
    
    private func createWeatherView(systemName: String, value: String?) -> some View {
        HStack {
            Image(systemName: systemName)
                .foregroundColor(.accent)
            if let value = value {
                Regular(text: value)
            } else {
                ProgressView()
            }
        }
    }
}
