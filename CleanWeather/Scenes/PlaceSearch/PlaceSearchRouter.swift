//
//  PlaceSearchRouter.swift
//  CleanWeather
//
//  Created by 18592232 on 13.09.2020.
//  Copyright © 2020 18592232. All rights reserved.
//

import Foundation

protocol PlaceSearchRoutingLogic
{
    func routeToListWeathers()
}

protocol PlaceSearchDataPassing
{
    //var dataStore: ListWeathersDataStore? { get }
}

class PlaceSearchRouter: PlaceSearchRoutingLogic, PlaceSearchDataPassing
{
    func routeToListWeathers() {
        
    }
    
    weak var viewController: PlaceSearchViewController?
    
    func routeToMainWeather(selectedCell: Int) {
        //let destinationVC = WeathersInfoViewController(startPosition: selectedCell)
        //var destinationDS = destinationVC.router!.dataStore!
        //passDataToShowOrder(source: dataStore!, destination: &destinationDS)
        //navigateToShowOrder(source: viewController!, destination: destinationVC)
    }
    
    func navigateToShowOrder(source: ListWeathersViewController, destination: WeathersInfoViewController)
    {
        //source.show(destination, sender: nil)
    }
    
    func passDataToShowOrder(source: ListWeathersDataStore, destination: inout WeathersInfoDataStore)
    {
        //destination.weathers = source.weathers
    }
}
