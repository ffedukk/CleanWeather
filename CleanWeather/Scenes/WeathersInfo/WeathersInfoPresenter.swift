//
//  WeathersInfoPresenter.swift
//  CleanWeather
//
//  Created by 18592232 on 10.09.2020.
//  Copyright © 2020 18592232. All rights reserved.
//

import UIKit

//    MARK: Protocols

protocol WeathersInfoPresentationLogic
{
    func presentFetchedWeathers(response: WeathersInfo.FetchWeathers.Response)
}

//    MARK: Presenter

class WeathersInfoPresenter: WeathersInfoPresentationLogic {
    
    weak var viewController: WeathersInfoDisplayLogic?
    
    func presentFetchedWeathers(response: WeathersInfo.FetchWeathers.Response) {
        var displayedWeathers: [WeathersInfoDisplayedTownProtocol] = []
        
        for weather in response.weathers {
            
            let icon = "Main" + weather.icon
            let temperature = fromKelvinToCelcius(kelvin: weather.temperature)
            let temperatureMax = fromKelvinToCelcius(kelvin: weather.temperatureMax)
            let temperatureMin = fromKelvinToCelcius(kelvin: weather.temperatureMin)
            
            let header = WeathersInfo.FetchWeathers.ViewModel.DisplayedTown.Header(placeName: weather.placeName, weatherDescription: weather.weatherDescription, temperature: temperature, temperatureMax: temperatureMax, temperatureMin: temperatureMin)
            
            var forecastDateArray: [WeathersInfo.FetchWeathers.ViewModel.DisplayedTown.DisplayedForecasts.ForecastForTime] = []
            for forecast in weather.forecastList {
                let time = fromDateToTime(date: forecast.time)
                let forcastTemperature = fromKelvinToCelcius(kelvin: forecast.temperature)
                forecastDateArray.append(WeathersInfo.FetchWeathers.ViewModel.DisplayedTown.DisplayedForecasts.ForecastForTime(time: time, temperature: forcastTemperature, icon: forecast.icon))
            }
            
            let displayedForecast = WeathersInfo.FetchWeathers.ViewModel.DisplayedTown.DisplayedForecasts(displayedForecast: forecastDateArray)
            
            let sunrise = fromIntToDate(integer: weather.sunrise)
            let sunset = fromIntToDate(integer: weather.sunset)
            let feelsLike = fromKelvinToCelcius(kelvin: weather.feelsLike)
            let pressure = fromHPAtoMM(hpa: weather.pressure)

            let sunriseView = WeathersInfo.FetchWeathers.ViewModel.DisplayedTown.AdditionalInfo(title: "Sunrise", data: sunrise)
            let sunsetView = WeathersInfo.FetchWeathers.ViewModel.DisplayedTown.AdditionalInfo(title: "Sunset", data: sunset)
            let windView = WeathersInfo.FetchWeathers.ViewModel.DisplayedTown.AdditionalInfo(title: "Wind Speed", data: String(weather.windSpeed))
            let feelsView = WeathersInfo.FetchWeathers.ViewModel.DisplayedTown.AdditionalInfo(title: "Feels Like", data: feelsLike)
            let pressureView = WeathersInfo.FetchWeathers.ViewModel.DisplayedTown.AdditionalInfo(title: "Pressure", data: pressure)
            
            let displayedViews: [DisplayedViewsForTownProtocol] = [header, displayedForecast, sunriseView, sunsetView, windView, feelsView, pressureView]
            
            let town = WeathersInfo.FetchWeathers.ViewModel.DisplayedTown(icon: icon, displayedViewsForTown: displayedViews)
                        
            displayedWeathers.append(town)
        }
        
        let viewModel = WeathersInfo.FetchWeathers.ViewModel(displayedWeathers: displayedWeathers)
        viewController?.displayFetchedWeathers(viewModel: viewModel)
        
    }
    
    
//    MARK: Format Functions
    
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
