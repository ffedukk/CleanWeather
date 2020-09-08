//
//  ListWeathersModels.swift
//  CleanWeather
//
//  Created by 18592232 on 08.09.2020.
//  Copyright © 2020 18592232. All rights reserved.
//

import UIKit

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
            struct DisplayedWeather
            {
                var town: Town
                struct Town {
                    var icon: String
                    var header: Header
                    var listOfForecast: DisplayedForecasts
                    var additionalInfo: AdditionalInfo
                    
                    struct Header {
                        var placeName: String
                        var weatherDescription: String
                        var temperature: String
                        var temperatureMax: String
                        var temperatureMin: String
                    }
                    struct DisplayedForecasts {
                        struct ForecastForTime {
                            var time: String
                            var temperature: String
                            var icon: String
                        }
                        var displayedForecast: [ForecastForTime]
                    }
                    struct AdditionalInfo {
                        var sunriseDescription: String
                        var sunrise: String
                        var sunsetDescription: String
                        var sunset: String
                        var windSpeedDescription: String
                        var windSpeed: String
                        var feelsLikeDescription: String
                        var feelsLike: String
                        var pressureDescription: String
                        var pressure: String
                    }
                }
            }
            var displayedWeathers: [DisplayedWeather]
        }
    }
}
