//
//  ListWeathersRouter.swift
//  CleanWeather
//
//  Created by 18592232 on 11.09.2020.
//  Copyright © 2020 18592232. All rights reserved.
//

import UIKit

@objc protocol ListWeathersRoutingLogic
{
    func routeToMainWeather()
    
}

protocol ListWeathersDataPassing
{
    var dataStore: ListWeathersDataStore? { get }
}

class ListWeathersRouter: NSObject, ListWeathersRoutingLogic, ListWeathersDataPassing
{
    
    
    weak var viewController: ListWeathersViewController?
    var dataStore: ListWeathersDataStore?
    
    func routeToMainWeather() {
        
    }
}
