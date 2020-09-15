//
//  JSONForecastParser.swift
//  CleanWeather
//
//  Created by 18592232 on 06.09.2020.
//  Copyright © 2020 18592232. All rights reserved.
//

import Foundation

class JSONForecastParser: ParserProtocol {
    func parse(_ data: Data) -> [[String:Any]]? {
        var result = [[String:Any]]()
        
        do {
            if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] {
                guard let jsonList = json["list"] as? [[String:Any]] else { return nil }
                for object in jsonList {
                    var dict = [String:Any]()
                    guard let mainInfo = object["main"] as? [String:Any] else { break }
                    if let temp = mainInfo["temp"] as? Double {
                        dict["temp"] = temp
                    }
                    guard let weatherInfoList = object["weather"] as? [[String:Any]] else { break }
                    if let weather = weatherInfoList[0]["main"] as? String {
                        dict["weather"] = weather
                    }
                    if let date = object["dt_txt"] as? String {
                        dict["date"] = date
                    }
                    result.append(dict)
                }
            }
        } catch {
            print("JSON error: \(error.localizedDescription)")
            return nil
        }
        return result
    }
}
