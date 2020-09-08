//
//  ListWeathersPresenter.swift
//  CleanWeather
//
//  Created by 18592232 on 06.09.2020.
//  Copyright © 2020 18592232. All rights reserved.
//

import UIKit

protocol ListWeathersPresentationLogic
{
    func presentFetchedWeathers(weathers: [Weather])//response: ListOrders.FetchOrders.Response)
}

class ListWeathersPresenter: ListWeathersPresentationLogic {
    
    weak var viewController: ListWeathersDisplayLogic?
    
    func presentFetchedWeathers(weathers: [Weather]) {
        var displayedWeathers: [ListWeathers.FetchWeathers.ViewModel.DisplayedWeather] = []
        
        for weather in weathers {
            
            let icon = "Main" + weather.icon
            let temperature = fromKelvinToCelcius(kelvin: weather.temperature)
            let temperatureMax = fromKelvinToCelcius(kelvin: weather.temperatureMax)
            let temperatureMin = fromKelvinToCelcius(kelvin: weather.temperatureMin)
            
            let header = ListWeathers.FetchWeathers.ViewModel.DisplayedWeather.Town.Header(placeName: weather.placeName, weatherDescription: weather.weatherDescription, temperature: temperature, temperatureMax: temperatureMax, temperatureMin: temperatureMin)
            
            var forecastDateArray: [ListWeathers.FetchWeathers.ViewModel.DisplayedWeather.Town.DisplayedForecasts.ForecastForTime] = []
            for forecast in weather.forecastList {
                let time = fromDateToTime(date: forecast.time)
                let forcastTemperature = fromKelvinToCelcius(kelvin: forecast.temperature)
                forecastDateArray.append(ListWeathers.FetchWeathers.ViewModel.DisplayedWeather.Town.DisplayedForecasts.ForecastForTime(time: time, temperature: forcastTemperature, icon: forecast.icon))
            }
            
            let displayedForecast = ListWeathers.FetchWeathers.ViewModel.DisplayedWeather.Town.DisplayedForecasts(displayedForecast: forecastDateArray)
            
            let sunrise = fromIntToDate(integer: weather.sunrise)
            let sunset = fromIntToDate(integer: weather.sunset)
            let feelsLike = fromKelvinToCelcius(kelvin: weather.feelsLike)
            let pressure = fromHPAtoMM(hpa: weather.pressure)
            
            let additionalInfo = ListWeathers.FetchWeathers.ViewModel.DisplayedWeather.Town.AdditionalInfo(sunriseDescription: "Sunrise", sunrise: sunrise, sunsetDescription: "Sunset", sunset: sunset, windSpeedDescription: "Wind Speed", windSpeed: String(weather.windSpeed), feelsLikeDescription: "Feels Like", feelsLike: feelsLike, pressureDescription: "Pressure", pressure: pressure)
            
            let town = ListWeathers.FetchWeathers.ViewModel.DisplayedWeather.Town(icon: icon, header: header, listOfForecast: displayedForecast, additionalInfo: additionalInfo)
            
            let displayedWeather = ListWeathers.FetchWeathers.ViewModel.DisplayedWeather(town: town)
            
            displayedWeathers.append(displayedWeather)
        }
        
        let viewModel = ListWeathers.FetchWeathers.ViewModel(displayedWeathers: displayedWeathers)
        viewController?.displayFetchedWeathers(viewModel: viewModel)
        
    }
    
    
    
    
    
    
    
    private func fromKelvinToCelcius(kelvin: Double) -> String {
        let celcius = Int(kelvin - 273.15)
        return "\(celcius)°C"
    }
    
    private func fromDateToTime(date: String) -> String {
        let startIndex = date.firstIndex(of: " ")!
        let endIndex = date.index(date.endIndex, offsetBy: -4)
        let time = date[startIndex...endIndex]
        return String(time)
    }
    
    private func fromHPAtoMM(hpa: Double) -> String {
        let mm = Double(round(100*(hpa/1.333))/100)
        return "\(mm) mm"
    }
    
    private func fromIntToDate(integer: Int64) -> String {
        let myNSDate = Date(timeIntervalSince1970: TimeInterval(integer))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let time = dateFormatter.string(from: myNSDate)
        return time
    }
    
}
