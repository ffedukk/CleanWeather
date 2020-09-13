//
//  PlaceSearchNetworkWorker.swift
//  CleanWeather
//
//  Created by 18592232 on 13.09.2020.
//  Copyright © 2020 18592232. All rights reserved.
//

import UIKit

class PlaceSearchNetworkWorker {
    
    weak var networkManager = (UIApplication.shared.delegate as! AppDelegate).networkManager

    
    func getTownPrediction(prediction: String, comletion: @escaping ([String]) -> ()) {
        if prediction.isEmpty {
            comletion([])
            return
        }
        guard
            let predictionURL = URL(string: prediction),
                let networkManager = networkManager
        else { return }
        
        networkManager.fetchResult(url: predictionURL, parser: JSONPredictionParser()) { result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    comletion(data)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
