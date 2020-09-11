//
//  WeathersInfoRouter.swift
//  CleanWeather
//
//  Created by 18592232 on 11.09.2020.
//  Copyright © 2020 18592232. All rights reserved.
//

import UIKit

@objc protocol WeathersInfoRoutingLogic
{
    func routeToMainWeather()
    
}

protocol WeathersInfoDataPassing
{
    var dataStore: WeathersInfoDataStore? { get }
}

class WeathersInfoRouter: WeathersInfoRoutingLogic, WeathersInfoDataPassing {
    weak var viewController: WeathersInfoViewController?
    var dataStore: WeathersInfoDataStore?
    
    func routeToMainWeather() {

    }
    
    func navigateToShowOrder(source: ListWeathersViewController, destination: WeathersInfoViewController)
    {
  
    }
    
    func passDataToShowOrder(source: ListWeathersDataStore, destination: inout WeathersInfoDataStore)
    {
 
    }
}
