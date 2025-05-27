//
//  HomeViewModel.swift
//  ToDoApp
//
//  Created by Marie Harmsen on 25/05/2025.
//

import SwiftUI
import Foundation
import CoreLocation

class HomeViewModel: ObservableObject, LocationManagerDelegate {
    private var locationManager: LocationMnagerProtocol
    @Published var shouldShowAlert: Bool = false
    @Published var flowState: FlowState = .loading
    
    var lat: Double? = nil
    var long: Double? = nil

    init(locationManager: LocationMnagerProtocol) {
        self.locationManager = locationManager
        self.locationManager.delegate = self
    }

    func didUpdateLocation(latitude: Double?, longitude: Double?, error: LocationError?) {
        if let error = error {
            switch error {
            case .locationError:
                updateFlowState(state: .error)
            case .userPermission:
                DispatchQueue.main.async { [weak self] in
                    self?.shouldShowAlert = true
                }
            }
            return
        }
        lat = latitude
        long = longitude
        updateFlowState(state: .success)
    }
    
    private func updateFlowState(state: FlowState) {
        DispatchQueue.main.async { [weak self] in
            self?.flowState = state
        }
    }
}
