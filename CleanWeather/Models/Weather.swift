//
//  Weather.swift
//  CleanWeather
//
//  Created by 18592232 on 06.09.2020.
//  Copyright © 2020 18592232. All rights reserved.
//

import Foundation

struct Weather {
    var feelsLike: Double
    var placeName: String
    var pressure: Double
    var sunrise: Int64
    var sunset: Int64
    var temperature: Double
    var temperatureMax: Double
    var temperatureMin: Double
    var icon: String
    var weatherDescription: String
    var windSpeed: Double
    var forecastList: [Forecast] = []
    
    struct Forecast {
        var time: String
        var temperature: Double
        var icon: String
        
        init(with managedForecast: ManagedForecast) {
            time = managedForecast.time!
            temperature = managedForecast.temperature
            icon = managedForecast.icon!
        }
    }
    
    init?(with managedWeather: ManagedWeather) {
        feelsLike = managedWeather.feelsLike
        placeName = managedWeather.placeName!
        pressure = managedWeather.pressure
        sunrise = managedWeather.sunrise
        sunset = managedWeather.sunset
        temperature = managedWeather.temperature
        temperatureMax = managedWeather.temperatureMax
        temperatureMin = managedWeather.temperatureMin
        icon = managedWeather.icon!
        weatherDescription = managedWeather.weatherDescription!
        windSpeed = managedWeather.windSpeed
        
        let forecastArray = managedWeather.managedForecast?.array as! [ManagedForecast]
        for forecast in forecastArray {
            forecastList.append(Forecast(with: forecast))
        }
    }
}
