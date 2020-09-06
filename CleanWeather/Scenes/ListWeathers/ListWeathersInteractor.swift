//
//  ListWeathersInteractor.swift
//  CleanWeather
//
//  Created by 18592232 on 06.09.2020.
//  Copyright © 2020 18592232. All rights reserved.
//

import UIKit

protocol ListWeathersBusinessLogic
{
  func fetchWeathers()//request: ListOrders.FetchOrders.Request)
}

protocol ListWeathersDataStore
{
  var weathers: [Weather]? { get }
}

class ListWeathersInteractor: ListWeathersBusinessLogic, ListWeathersDataStore {
    
    var presenter: ListWeathersPresentationLogic?
    
    func fetchWeathers() {
        
    }
    
    var weathers: [Weather]?
    
    
}
