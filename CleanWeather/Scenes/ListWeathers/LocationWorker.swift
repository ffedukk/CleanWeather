//
//  ListWeathersLocationWorker.swift
//  CleanWeather
//
//  Created by 18592232 on 08.09.2020.
//  Copyright © 2020 18592232. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class LocationWorker: NSObject, CLLocationManagerDelegate {
    
    weak var interactor: ListWeatherLocation?
    private let locationManager = CLLocationManager()
    var latitude: String?
    var longitude: String?
    
    override init() {
        super.init()
        setupLocation()
    }
    
    func startUpdateLocation() {
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }

        latitude = String(Double(locValue.latitude))
        longitude = String(Double(locValue.longitude))
        locationManager.stopUpdatingLocation()
        interactor?.addWeatherInLocation(latitude: latitude!, longitude: longitude!)
    }
    
    func setupLocation() {
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        }
    }
}
