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
                Spacer()
                createWeatherView(systemName: "sunrise", value: viewModel.sunrise)
                Spacer()
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
        VStack {
            Image(systemName: systemName)
                .foregroundColor(.accent)
            if let value = value {
                Small(text: value)
            } else {
                ProgressView()
            }
        }
    }
}
