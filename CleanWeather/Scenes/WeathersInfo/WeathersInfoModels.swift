//
//  WeathersInfoModels.swift
//  CleanWeather
//
//  Created by 18592232 on 10.09.2020.
//  Copyright © 2020 18592232. All rights reserved.
//

import UIKit

protocol WeathersInfoViewModelProtocol {
    var identifire: String { get }
}

protocol WeathersInfoDisplayedTownProtocol: WeathersInfoViewModelProtocol {
    var identifire: String { get }
    var icon: String { get  }
    var displayedViewsForTown: [DisplayedViewsForTownProtocol] { get }
    //var header: WeathersInfo.FetchWeathers.ViewModel.DisplayedTown.Header { get  }
    //var listOfForecast: WeathersInfo.FetchWeathers.ViewModel.DisplayedTown.DisplayedForecasts { get  }
    //var additionalInfo: WeathersInfo.FetchWeathers.ViewModel.DisplayedTown.AdditionalInfo { get  }
}



protocol DisplayedViewsForTownProtocol {
    var identifire: String { get }
}

protocol WeathersInfoDisplayedHeaderProtocol: DisplayedViewsForTownProtocol {
    var placeName: String { get }
    var weatherDescription: String { get }
    var temperature: String { get }
    var temperatureMax: String { get }
    var temperatureMin: String { get }
    
}

protocol WeathersInfoDisplayedForecastsProtocol: DisplayedViewsForTownProtocol {
    var displayedForecast: [WeathersInfo.FetchWeathers.ViewModel.DisplayedTown.DisplayedForecasts.ForecastForTime] { get }
}

protocol WeathersInfoDisplayedAdditionalInfoProtocol: DisplayedViewsForTownProtocol {
    var title: String { get }
    var data: String { get }
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
                //var header: Header
                //var listOfForecast: DisplayedForecasts
                //var additionalInfo: AdditionalInfo
                
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
                    struct ForecastForTime {
                        var time: String
                        var temperature: String
                        var icon: String
                    }
                    var displayedForecast: [ForecastForTime]
                }
                struct AdditionalInfo: WeathersInfoDisplayedAdditionalInfoProtocol {
                    var identifire: String = "weathersInfoAdditionalInfoCell"
                    var title: String
                    var data: String
                }
                var displayedViewsForTown: [DisplayedViewsForTownProtocol]
            }
            var displayedWeathers: [WeathersInfoDisplayedTownProtocol]
        }
    }
}
