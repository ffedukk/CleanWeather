//
//  JSONWeatherParser.swift
//  CleanWeather
//
//  Created by 18592232 on 06.09.2020.
//  Copyright © 2020 18592232. All rights reserved.
//

import Foundation

class JSONWeatherParser: ParserProtocol {
    typealias Result = [String:Any]
    func parse(_ data: Data) -> Result? {
        var result = [String:Any]()
        
        do {
            if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] {
                guard let weatherInfoList = json["weather"] as? [[String:Any]] else { return nil }
                if let weather = weatherInfoList[0]["main"] as? String {
                    result["weather"] = weather
                }
                if let weatherDescription = weatherInfoList[0]["main"] as? String {
                    result["weatherDescription"] = weatherDescription
                }
                
                guard let mainInfo = json["main"] as? [String:Any] else {fatalError()}
                if let temp = mainInfo["temp"] as? Double {
                    result["temp"] = temp
                }
                if let feelsLike = mainInfo["feels_like"] as? Double {
                    result["feelsLike"] = feelsLike
                }
                if let tempMin = mainInfo["temp_min"] as? Double {
                    result["tempMin"] = tempMin
                }
                if let tempMax = mainInfo["temp_max"] as? Double {
                    result["tempMax"] = tempMax
                }
                if let pressure = mainInfo["pressure"] as? Double {
                    result["pressure"] = pressure
                }
                
                guard let windInfo = json["wind"] as? [String:Any] else {fatalError()}
                if let windSpeed = windInfo["speed"] as? Double {
                    result["windSpeed"] = windSpeed
                }
                
                guard let sun = json["sys"] as? [String:Any] else {fatalError()}
                if let sunrise = sun["sunrise"] as? Int {
                    result["sunrise"] = sunrise
                }
                if let sunset = sun["sunset"] as? Int {
                    result["sunset"] = sunset
                }
                
                if let name = json["name"] as? String {
                    result["name"] = name
                }
            }
        } catch {
            print("JSON error: \(error.localizedDescription)")
            return nil
        }
        return result
    }
}
