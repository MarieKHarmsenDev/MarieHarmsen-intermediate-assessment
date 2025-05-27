//
//  LocationManager.swift
//  ToDoApp
//
//  Created by Marie Harmsen on 25/05/2025.
//

import CoreLocation
import Foundation

enum LocationError: Error {
    case locationError
    case locationManagerError
    case userPermission
}

protocol LocationManagerDelegate: AnyObject {
    func didUpdateLocation(latitude: Double?, longitude: Double?, error: LocationError?)
}

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    weak var delegate: LocationManagerDelegate?
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    private func handleLocationAuthorised() {
        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted, .denied:
            delegate?.didUpdateLocation(latitude: nil, longitude: nil, error: .userPermission)
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
        default:
            locationManager.requestWhenInUseAuthorization()
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let latestLocation = locations.last else {
            delegate?.didUpdateLocation(latitude: nil, longitude: nil, error: .locationError)
            return
        }
        locationManager.stopUpdatingLocation()
        delegate?.didUpdateLocation(latitude: latestLocation.coordinate.latitude, longitude: latestLocation.coordinate.longitude, error: nil)
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        handleLocationAuthorised()
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        delegate?.didUpdateLocation(latitude: nil, longitude: nil, error: .locationManagerError)
    }
}
