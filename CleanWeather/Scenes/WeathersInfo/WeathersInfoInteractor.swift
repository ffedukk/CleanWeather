//
//  WeathersInfoInteractor.swift
//  CleanWeather
//
//  Created by 18592232 on 10.09.2020.
//  Copyright © 2020 18592232. All rights reserved.
//

import Foundation

//    MARK: Protocols

protocol WeathersInfoBusinessLogic
{
    func fetchWeathers()
    func updateWeathers()
}

protocol WeathersInfoDataStore
{
    var weathers: [Weather]? { get set }
}

//protocol WeathersInfoLocation: class {
//    func addWeatherInLocation(latitude: String, longitude: String)
//}

//    MARK: Interactor

class WeathersInfoInteractor: WeathersInfoBusinessLogic, WeathersInfoDataStore, ListWeatherLocation {
    
    var presenter: WeathersInfoPresentationLogic?
    var networkWorker = NetworkWorker()
    var coreDataWorker = CoreDataWorker()
    var locationWorker = LocationWorker()
    
    var weathers: [Weather]?
    
    let weatherAPIKey: String
    
//    MARK: Updating
        
    func updateWeathers() {
        guard let _ = weathers else { return }
        
        for index in 1..<weathers!.count {
            
            let place = weathers![index].placeName
            let weatherURL = "http://api.openweathermap.org/data/2.5/weather?q=\(place)&appid=\(weatherAPIKey)"
            let forecastURL = "http://api.openweathermap.org/data/2.5/forecast?q=\(place)&appid=\(weatherAPIKey)"

            networkWorker.getWeatherData(weatherURL: weatherURL, forecastURL: forecastURL) { [weak self] (weatherData, forecastData) in
                guard let self = self else { return }
                self.coreDataWorker.updateItem(weatherData: weatherData, forecastData: forecastData, at: index) { (managedWeather) in
                    if let updatedWeather = Weather(with: managedWeather) {
                        self.weathers![index] = updatedWeather
                    }
                }
            }
        }
        let response = WeathersInfo.FetchWeathers.Response(weathers: self.weathers!)
        self.presenter?.presentFetchedWeathers(response: response)
    }
    
//    MARK: Fetching
    
    func fetchWeathers() {
        let response = WeathersInfo.FetchWeathers.Response(weathers: self.weathers!)
        self.presenter?.presentFetchedWeathers(response: response)
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
                            let response = WeathersInfo.FetchWeathers.Response(weathers: self.weathers!)
                            self.presenter?.presentFetchedWeathers(response: response)
                        }
                    }
                } else {
                    self.coreDataWorker.updateItem(weatherData: weatherData, forecastData: forecastData, at: 0) { [weak self] (managedWeather) in
                        guard let self = self else { return }
                        if let updatedWeather = Weather(with: managedWeather) {
                            self.weathers![0] = updatedWeather
                            let response = WeathersInfo.FetchWeathers.Response(weathers: self.weathers!)
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
