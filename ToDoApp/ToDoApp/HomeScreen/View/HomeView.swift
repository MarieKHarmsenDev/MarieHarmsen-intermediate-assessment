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
    @Environment(\.modelContext) private var modelContext
    @State private var toDoViewModel: ToDoViewModel?
    
    @State private var showBottomSheet = false
    
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
            if let toDoViewModel {
                Title1(text: "weatherView.title".localized)
                if let lat = viewModel.lat, let long = viewModel.long {
                    WeatherView(viewModel: WeatherViewModel(network:
                                                            NetworkManager(latitude: String(lat), longitude: String(long))))
                }
                ToDoView(viewModel: toDoViewModel)
                PrimaryButton(action: {showBottomSheet = true }, imageName: "plus.circle.fill", buttonText: "homeView.listbutton.title".localized, isDisabled: false)
                Spacer()
            } else {
                ErrorView()
            }
        }
        .sheet(isPresented: $showBottomSheet) {
            if let toDoViewModel {
                CreateToDoListView(viewModel: toDoViewModel)
                    .presentationDetents([.medium, .large])
            }
        }
        .onAppear() {
            toDoViewModel = ToDoViewModel(modelContext: modelContext)
        }
    }
}

#Preview {
    HomeView()
}
