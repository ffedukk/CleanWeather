//
//  ListWeathersModels.swift
//  CleanWeather
//
//  Created by 18592232 on 08.09.2020.
//  Copyright © 2020 18592232. All rights reserved.
//

import Foundation


protocol ListWeathersViewModelProtocol {
    var identifire: String { get }
}

protocol ListWeathersDisplayedLocationProtocol: ListWeathersViewModelProtocol {
    var placeName: String { get }
    var icon: String { get }
    var temperature: String { get }
}

protocol ListWeathersDisplayedProtocol: ListWeathersViewModelProtocol {
    var placeName: String { get }
    var icon: String { get }
    var temperature: String { get }
}

protocol ListWeathersDisplayedButtonsProtocol: ListWeathersViewModelProtocol {
    
}

enum ListWeathers
{
    // MARK: Use cases
    
    enum FetchWeathers
    {
        struct Request
        {
        }
        struct Response
        {
            var weathers: [Weather]
        }
        struct ViewModel
        {
            struct DisplayedWeatherLocation: ListWeathersDisplayedLocationProtocol {
                let identifire = "listWeathersLocationCell"
                var placeName: String
                var icon: String
                var temperature: String
            }
            struct DisplayedWeather: ListWeathersDisplayedProtocol
            {
                let identifire = "listWeathersCell"
                var placeName: String
                var icon: String
                var temperature: String
            }
            struct Buttons: ListWeathersDisplayedButtonsProtocol {
                let identifire = "listWeathersButtonsCell"
            }
            var displayedItems: [ListWeathersViewModelProtocol]
        }
    }
}
