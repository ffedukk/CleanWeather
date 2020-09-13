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
    func routeToListWeathers(with town: String)
}

protocol PlaceSearchDataPassing
{
    var dataStore: ListWeathersDataStore? { get }
}

class PlaceSearchRouter: PlaceSearchRoutingLogic, PlaceSearchDataPassing
{
    var dataStore: ListWeathersDataStore?
    weak var viewController: PlaceSearchViewController?
    
    
    func routeToListWeathers(with town: String) {
        guard let controllers = viewController?.navigationController?.viewControllers else { return }
        for controller in controllers {
            if let destinationVC = controller as? ListWeathersViewController {
                destinationVC.interactor?.addWeather(place: town)
                //viewController?.dismiss(animated: true, completion: nil)
                viewController?.navigationController?.popViewController(animated: true)
            }
        }
//        let destinationVC = WeathersInfoViewController(startPosition: selectedCell)
//        var destinationDS = destinationVC.router!.dataStore!
//        passDataToShowOrder(source: dataStore!, destination: &destinationDS)
//        navigateToShowOrder(source: viewController!, destination: destinationVC)
    }
    
    
    
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
    
    func passDataToListWeathers(source: ListWeathersDataStore, destination: inout WeathersInfoDataStore)
    {
        //destination.weathers = source.weathers
    }
}
