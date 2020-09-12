//
//  ListWeathersInteractor.swift
//  CleanWeather
//
//  Created by 18592232 on 06.09.2020.
//  Copyright © 2020 18592232. All rights reserved.
//

import UIKit

//    MARK: Protocols

protocol ListWeathersBusinessLogic
{
    func fetchWeathersFromCoreData(request: ListWeathers.FetchWeathers.Request)
    func updateWeathers()
    func addWeather(place: String)
    func deleteWeather(at index: Int)
}

protocol ListWeathersDataStore
{
    var weathers: [Weather]? { get }
}

protocol ListWeatherLocation: class {
    func addWeatherInLocation(latitude: String, longitude: String)
}

//    MARK: Interactor

class ListWeathersInteractor: ListWeathersBusinessLogic, ListWeathersDataStore, ListWeatherLocation {
    
    var presenter: ListWeathersPresentationLogic?
    var networkWorker = NetworkWorker()
    var coreDataWorker = CoreDataWorker()
    var locationWorker = LocationWorker()
    
    var weathers: [Weather]?
    
    let weatherAPIKey: String
    
//    MARK: Deletion
    
    func deleteWeather(at index: Int) {
        coreDataWorker.deleteFromData(at: index) {
            weathers?.remove(at: index)
            let response = ListWeathers.FetchWeathers.Response(weathers: self.weathers!)
            self.presenter?.presentFetchedWeathers(response: response)
        }
    }
    
//    MARK: Updating
        
    func updateWeathers() {
        
        locationWorker.startUpdateLocation()
        guard var weathers = weathers, !weathers.isEmpty else { return }
        
        for index in 1..<weathers.count {

            let place = weathers[index].placeName
            let weatherURL = "http://api.openweathermap.org/data/2.5/weather?q=\(place)&appid=\(weatherAPIKey)"
            let forecastURL = "http://api.openweathermap.org/data/2.5/forecast?q=\(place)&appid=\(weatherAPIKey)"

            networkWorker.getWeatherData(weatherURL: weatherURL, forecastURL: forecastURL) { [weak self] (weatherData, forecastData) in
                guard let self = self else { return }
                self.coreDataWorker.updateItem(weatherData: weatherData, forecastData: forecastData, at: index) { (managedWeather) in
                    if let updatedWeather = Weather(with: managedWeather) {
                        weathers[index] = updatedWeather
                    }
                }
            }
        }
        let response = ListWeathers.FetchWeathers.Response(weathers: self.weathers!)
        self.presenter?.presentFetchedWeathers(response: response)
    }
    
//    MARK: Fetching
    
    func fetchWeathersFromCoreData(request: ListWeathers.FetchWeathers.Request) {
        
        coreDataWorker.fetch { [weak self] (managedWeathers) in
            guard let self = self else { return }
            var fetchedWeathers: [Weather] = []
            for managedWeather in managedWeathers {
                if let fetchedWeather = Weather(with: managedWeather) {
                    fetchedWeathers.append(fetchedWeather)
                }
            }
            self.weathers = fetchedWeathers
            let response = ListWeathers.FetchWeathers.Response(weathers: self.weathers!)
            self.presenter?.presentFetchedWeathers(response: response)
        }
    }

//    MARK: Adding
    
    func addWeather(place: String) {
        
        let weatherURL = "http://api.openweathermap.org/data/2.5/weather?q=\(place)&appid=\(weatherAPIKey)"
        let forecastURL = "http://api.openweathermap.org/data/2.5/forecast?q=\(place)&appid=\(weatherAPIKey)"

        networkWorker.getWeatherData(weatherURL: weatherURL, forecastURL: forecastURL) { [weak self] (weatherData, forecastData) in
            guard let self = self else { return }
            
            self.coreDataWorker.add(weatherData: weatherData, forecastData: forecastData) { [weak self] (managedWeather) in
                guard let self = self else { return }
                
                if let newWeather = Weather(with: managedWeather) {
                    if let _ = self.weathers {
                        self.weathers?.append(newWeather)
                    } else {
                        self.weathers = [newWeather]
                    }
                    let response = ListWeathers.FetchWeathers.Response(weathers: self.weathers!)
                    self.presenter?.presentFetchedWeathers(response: response)
                }
            }
        }
    }
    
//    MARK: Updating Location
    
    func addWeatherInLocation(latitude: String, longitude: String) {
        print(latitude, longitude)
        
        let weatherURL = "http://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=\(weatherAPIKey)"
        let forecastURL = "http://api.openweathermap.org/data/2.5/forecast?lat=\(latitude)&lon=\(longitude)&appid=\(weatherAPIKey)"
        
        networkWorker.getWeatherData(weatherURL: weatherURL, forecastURL: forecastURL) { [weak self] (weatherData, forecastData) in
            guard let self = self else { return }
            
            if let _ = self.weathers {
                if self.weathers!.isEmpty {
                    self.coreDataWorker.add(weatherData: weatherData, forecastData: forecastData) { [weak self] (managedWeather) in
                        if let newWeather = Weather(with: managedWeather) {
                            guard let self = self else { return }
                            self.weathers!.append(newWeather)
                            let response = ListWeathers.FetchWeathers.Response(weathers: self.weathers!)
                            self.presenter?.presentFetchedWeathers(response: response)
                        }
                    }
                } else {
                    self.coreDataWorker.updateItem(weatherData: weatherData, forecastData: forecastData, at: 0) { [weak self] (managedWeather) in
                        guard let self = self else { return }
                        if let updatedWeather = Weather(with: managedWeather) {
                            self.weathers![0] = updatedWeather
                            let response = ListWeathers.FetchWeathers.Response(weathers: self.weathers!)
                            self.presenter?.presentFetchedWeathers(response: response)
                        }
                    }
                }
            }
        }
        
    }
    
//    MARK: Init
    
    init() {
        guard let keys = PlistAccess().getPlist(withName: "APIKeys") else { fatalError("Cannot read API KEY from plist") }
        weatherAPIKey = keys["WeatherAPIKey"]!
        locationWorker.interactor = self
    }
}
