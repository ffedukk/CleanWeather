//
//  WeathersInfoModels.swift
//  CleanWeather
//
//  Created by 18592232 on 10.09.2020.
//  Copyright © 2020 18592232. All rights reserved.
//

import Foundation


protocol WeathersInfoViewModelProtocol {
    var identifire: String { get }
}

protocol WeathersInfoDisplayedTownProtocol: WeathersInfoViewModelProtocol {
    var icon: String { get  }
    var displayedViewsForTown: [WeathersInfoViewModelProtocol] { get }
}

protocol WeathersInfoDisplayedHeaderProtocol: WeathersInfoViewModelProtocol {
    var placeName: String { get }
    var weatherDescription: String { get }
    var temperature: String { get }
    var temperatureMax: String { get }
    var temperatureMin: String { get }
}

protocol WeathersInfoDisplayedForecastsProtocol: WeathersInfoViewModelProtocol {
    var displayedForecast: [WeathersInfoViewModelProtocol] { get }
}

protocol WeathersInfoDisplayedAdditionalInfoProtocol: WeathersInfoViewModelProtocol {
    var title: String { get }
    var data: String { get }
}

protocol WeathersInfoForecastForTimeProtocol: WeathersInfoViewModelProtocol {
    var time: String { get }
    var temperature: String { get }
    var icon: String { get }
}

enum WeathersInfo
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
            struct DisplayedTown: WeathersInfoDisplayedTownProtocol {
                var identifire = "weathersInfoCell"
                var icon: String
                
                struct Header: WeathersInfoDisplayedHeaderProtocol {
                    var identifire: String = "weathersInfoHeaderCell"
                    var placeName: String
                    var weatherDescription: String
                    var temperature: String
                    var temperatureMax: String
                    var temperatureMin: String
                }
                struct DisplayedForecasts: WeathersInfoDisplayedForecastsProtocol {
                    var identifire: String = "weathersInfoForecastsCell"
                    struct ForecastForTime: WeathersInfoForecastForTimeProtocol {
                        var identifire: String = "weathersInfoForecastForTimeCell"
                        var time: String
                        var temperature: String
                        var icon: String
                    }
                    var displayedForecast: [WeathersInfoViewModelProtocol]
                }
                struct AdditionalInfo: WeathersInfoDisplayedAdditionalInfoProtocol {
                    var identifire: String = "weathersInfoAdditionalInfoCell"
                    var title: String
                    var data: String
                }
                var displayedViewsForTown: [WeathersInfoViewModelProtocol]
            }
            var displayedWeathers: [WeathersInfoViewModelProtocol]
        }
    }
}
