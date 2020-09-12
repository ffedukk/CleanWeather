//
//  ListWeathersPresenter.swift
//  CleanWeather
//
//  Created by 18592232 on 06.09.2020.
//  Copyright © 2020 18592232. All rights reserved.
//

import Foundation

//    MARK: Protocols

protocol ListWeathersPresentationLogic
{
    func presentFetchedWeathers(response: ListWeathers.FetchWeathers.Response)
}

//    MARK: Presenter

class ListWeathersPresenter: ListWeathersPresentationLogic {
    
    weak var viewController: ListWeathersDisplayLogic?
    
    func presentFetchedWeathers(response: ListWeathers.FetchWeathers.Response) {
        
        var displayedItems: [ListWeathersViewModelProtocol] = []
        
        for (index, weather) in response.weathers.enumerated() {
            let displayedItem: ListWeathersViewModelProtocol
            
            let icon = "Main" + weather.icon
            let temperature = fromKelvinToCelcius(kelvin: weather.temperature)
            if index == 0 {
                displayedItem = ListWeathers.FetchWeathers.ViewModel.DisplayedWeatherLocation(placeName: weather.placeName, icon: icon, temperature: temperature)
            } else {
                displayedItem = ListWeathers.FetchWeathers.ViewModel.DisplayedWeather(placeName: weather.placeName, icon: icon, temperature: temperature)
            }
            displayedItems.append(displayedItem)
        }
        displayedItems.append(ListWeathers.FetchWeathers.ViewModel.Buttons())
        
        let viewModel = ListWeathers.FetchWeathers.ViewModel(displayedItems: displayedItems)
        viewController?.displayFetchedWeathers(viewModel: viewModel)
    }
    
    
//    MARK: Format Functions
    
    private func fromKelvinToCelcius(kelvin: Double) -> String {
        let celcius = Int(kelvin - 273.15)
        return "\(celcius)°C"
    }
}
