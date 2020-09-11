//
//  ListWeathersPresenter.swift
//  CleanWeather
//
//  Created by 18592232 on 06.09.2020.
//  Copyright © 2020 18592232. All rights reserved.
//

import UIKit

//    MARK: Protocols

protocol ListWeathersPresentationLogic
{
    func presentFetchedWeathers(response: ListWeathers.FetchWeathers.Response)//weathers: [Weather])//response: ListOrders.FetchOrders.Response)
}

//    MARK: Presenter

class ListWeathersPresenter: ListWeathersPresentationLogic {
    
    weak var viewController: ListWeathersDisplayLogic?
    
    func presentFetchedWeathers(response: ListWeathers.FetchWeathers.Response) {//weathers: [Weather]) {
        var displayedWeathers: [ViewModelProtocol] = []
        
        for (index, weather) in response.weathers.enumerated() {
            let displayedWeather: ViewModelProtocol
            
            let icon = "Main" + weather.icon
            let temperature = fromKelvinToCelcius(kelvin: weather.temperature)
            if index == 0 {
                displayedWeather = ListWeathers.FetchWeathers.ViewModel.DisplayedWeatherLocation(placeName: weather.placeName, icon: icon, temperature: temperature)
            } else {
                displayedWeather = ListWeathers.FetchWeathers.ViewModel.DisplayedWeather(placeName: weather.placeName, icon: icon, temperature: temperature)
            }
            displayedWeathers.append(displayedWeather)
        }
        displayedWeathers.append(ListWeathers.FetchWeathers.ViewModel.Buttons())
        
        let viewModel = ListWeathers.FetchWeathers.ViewModel(displayedItems: displayedWeathers)
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
