//
//  HomeView.swift
//  ToDoApp
//
//  Created by Marie Harmsen on 25/05/2025.
//

import SwiftUI
import CoreLocation

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel(locationManager: LocationManager())
    
    var body: some View {
        switch viewModel.flowState {
        case .loading :
            loadingView
        case .error:
            ErrorView()
        case .success:
            successView
        }
    }
    
    private var loadingView: some View {
        LoadingView()
            .alert("locationPermission.alertTitle".localized, isPresented: $viewModel.shouldShowAlert) {
                Button("locationPermission.alertSettings".localized) {
                    if let url = URL(string: UIApplication.openSettingsURLString), UIApplication.shared.canOpenURL(url) {
                        UIApplication.shared.open(url)
                    }
                }
                Button("locationPermission.alertCancel".localized) {}
            } message: {
                Regular(text: "locationPermission.alertMessage".localized)
            }
    }
    
    private var successView: some View {
        VStack {
            Title1(text: "weatherView.title".localized)
            if let lat = viewModel.lat, let long = viewModel.long {
                WeatherView(viewModel: WeatherViewModel(network:
                                                            WeatherNetworkManager(latitude: String(lat), longitude: String(long))))
            }
            ListView()
            addButton
            Spacer()
        }
    }
    
    private var addButton: some View {
        Button(action: {
            print("Add to list")
        }) {
            HStack {
                Spacer()
                Image(systemName: "plus.circle.fill")
                    .font(.system(size: 24, weight: .bold))
                Regular(text: "homeView.listbutton.title".localized)
                Spacer()
            }
            .padding()
            .background(Color.orange)
            .foregroundColor(.white)
            .cornerRadius(12)
        }
        .padding(.horizontal, 16)
    }
}

#Preview {
    HomeView()
}
