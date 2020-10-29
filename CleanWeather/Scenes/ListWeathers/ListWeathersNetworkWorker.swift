//
//  NetworkWorker.swift
//  CleanWeather
//
//  Created by 18592232 on 06.09.2020.
//  Copyright © 2020 18592232. All rights reserved.
//

import UIKit

protocol ListWeathersNetworkWorkerProtocol {
    func getWeatherData(weatherURL: String, forecastURL: String, completion: @escaping ([String:Any],[[String:Any]]) -> ())
}

class ListWeathersNetworkWorker: ListWeathersNetworkWorkerProtocol {
    
    weak var networkManager = (UIApplication.shared.delegate as! AppDelegate).networkManager
    
    func getWeatherData(weatherURL: String, forecastURL: String, completion: @escaping ([String:Any],[[String:Any]]) -> ()) {
        
        let queue = OperationQueue()
        queue.qualityOfService = .background
        queue.maxConcurrentOperationCount = 2
        
        queue.addOperation {
            guard let url1 = URL(string: weatherURL),
                  let url2 = URL(string: forecastURL),
                  let networkManager = self.networkManager
            else { return }
            
            var weatherData: [String:Any] = [:]
            var forecastData: [[String:Any]] = []
            
            let group = DispatchGroup()
            group.enter()
            
            networkManager.fetchResult(url: url1, parser: JSONWeatherParser()) { (result) in
                switch result {
                case .success(let parseData):
                    weatherData = parseData
                case .failure(let error):
                    print(error)
                }
                group.leave()
            }
            group.enter()
            networkManager.fetchResult(url: url2, parser: JSONForecastParser()) { (result) in
                switch result {
                case .success(let parseData):
                    forecastData = parseData
                case .failure(let error):
                    print(error)
                }
                group.leave()
            }
            
            group.notify(queue: DispatchQueue.main) {
                if !weatherData.isEmpty && !forecastData.isEmpty {
                    completion(weatherData,forecastData)
                }
            }
        }
        //            guard let url1 = URL(string: weatherURL),
        //                  let url2 = URL(string: forecastURL),
        //                  let networkManager = self.networkManager
        //            else { return }
        //
        //            var weatherData: [String:Any] = [:]
        //            var forecastData: [[String:Any]] = []
        //
        //            let group = DispatchGroup()
        //            group.enter()
        //
        //            networkManager.fetchResult(url: url1, parser: JSONWeatherParser()) { (result) in
        //                switch result {
        //                case .success(let parseData):
        //                    weatherData = parseData
        //                case .failure(let error):
        //                    print(error)
        //                }
        //                group.leave()
        //            }
        //            group.enter()
        //            networkManager.fetchResult(url: url2, parser: JSONForecastParser()) { (result) in
        //                switch result {
        //                case .success(let parseData):
        //                    forecastData = parseData
        //                case .failure(let error):
        //                    print(error)
        //                }
        //                group.leave()
        //            }
        //
        //            group.notify(queue: DispatchQueue.main) {
        //                if !weatherData.isEmpty && !forecastData.isEmpty {
        //                    completion(weatherData,forecastData)
        //                }
        //            }
    }
    
}
