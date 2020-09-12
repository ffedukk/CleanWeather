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
    func routeToMainWeather(selectedCell: Int)
}

protocol ListWeathersDataPassing
{
    var dataStore: ListWeathersDataStore? { get }
}

class ListWeathersRouter: ListWeathersRoutingLogic, ListWeathersDataPassing
{
    weak var viewController: ListWeathersViewController?
    var dataStore: ListWeathersDataStore?
    
    func routeToMainWeather(selectedCell: Int) {
        let destinationVC = WeathersInfoViewController(startPosition: selectedCell)
        var destinationDS = destinationVC.router!.dataStore!
        passDataToShowOrder(source: dataStore!, destination: &destinationDS)
        navigateToShowOrder(source: viewController!, destination: destinationVC)
    }
    
    func navigateToShowOrder(source: ListWeathersViewController, destination: WeathersInfoViewController)
    {
        source.show(destination, sender: nil)
    }
    
    func passDataToShowOrder(source: ListWeathersDataStore, destination: inout WeathersInfoDataStore)
    {
        destination.weathers = source.weathers
    }
}
