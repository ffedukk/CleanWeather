//
//  ListWeathersModels.swift
//  CleanWeather
//
//  Created by 18592232 on 08.09.2020.
//  Copyright © 2020 18592232. All rights reserved.
//

import UIKit


protocol ViewModelProtocol {
    
}

protocol DisplayedWeatherProtocol: ViewModelProtocol {
    var placeName: String { get }
    var icon: String { get }
    var temperature: String { get }
}

protocol DisplayedWeatherButtonsProtocol: ViewModelProtocol {
    
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
            struct DisplayedWeather: DisplayedWeatherProtocol
            {
                var placeName: String
                var icon: String
                var temperature: String
            }
            struct Buttons: DisplayedWeatherButtonsProtocol {
                
            }
            var displayedItems: [ViewModelProtocol]
        }
    }
}
