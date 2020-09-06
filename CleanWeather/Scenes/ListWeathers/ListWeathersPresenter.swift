//
//  ListWeathersPresenter.swift
//  CleanWeather
//
//  Created by 18592232 on 06.09.2020.
//  Copyright © 2020 18592232. All rights reserved.
//

import UIKit

protocol ListWeathersPresentationLogic
{
    func presentFetchedWeathers()//response: ListOrders.FetchOrders.Response)
}


class ListWeathersPresenter: ListWeathersPresentationLogic {
    
    weak var viewController: ListWeathersDisplayLogic?
    
    func presentFetchedWeathers() {
        
    }
    
}
