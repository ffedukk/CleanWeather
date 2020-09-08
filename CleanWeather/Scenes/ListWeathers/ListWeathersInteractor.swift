//
//  ListWeathersInteractor.swift
//  CleanWeather
//
//  Created by 18592232 on 06.09.2020.
//  Copyright © 2020 18592232. All rights reserved.
//

import UIKit

protocol ListWeathersBusinessLogic
{
    func fetchWeathersFromCoreData()
    func updateWeathers()
    func addWeather(place: String)
    func deleteWeather(at index: Int)
}

protocol ListWeathersDataStore
{
    var weathers: [Weather]? { get }
}

class ListWeathersInteractor: ListWeathersBusinessLogic, ListWeathersDataStore {
    
    var presenter: ListWeathersPresentationLogic?
    var networkWorker = NetworkWorker()
    var coreDataWorker = CoreDataWorker()
    
    var weathers: [Weather]?
    
    let weatherAPIKey: String
    
    func deleteWeather(at index: Int) {
        coreDataWorker.deleteFromData(at: index) {
            weathers?.remove(at: index)
            presenter?.presentFetchedWeathers(weathers: weathers!)
        }
    }
        
    func updateWeathers() {
        guard let _ = weathers else { return }
        
        for index in 0..<weathers!.count {
            
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
        presenter?.presentFetchedWeathers(weathers: weathers!)
    }
    
    func fetchWeathersFromCoreData() {
        coreDataWorker.fetch { [weak self] (managedWeathers) in
            guard let self = self else { return }
            var fetchedWeathers: [Weather] = []
            for managedWeather in managedWeathers {
                if let fetchedWeather = Weather(with: managedWeather) {
                    fetchedWeathers.append(fetchedWeather)
                }
            }
            self.weathers = fetchedWeathers
            self.presenter?.presentFetchedWeathers(weathers: self.weathers!)
        }
    }

    
    
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
                    self.presenter?.presentFetchedWeathers(weathers: self.weathers!)
                }
            }
        }
    }
    
    
    
    init() {
        if let keys = PlistAccess().getPlist(withName: "APIKeys") {
            weatherAPIKey = keys["WeatherAPIKey"]!
        } else {
            weatherAPIKey = ""
        }
    }
}
