//
//  ListWeathersRouter.swift
//  CleanWeather
//
//  Created by 18592232 on 11.09.2020.
//  Copyright © 2020 18592232. All rights reserved.
//

import Foundation

protocol ListWeathersRoutingLogic {
    func routeToMainWeather(selectedCell: Int)
    func routeToPlaceSearch()
}

protocol ListWeathersDataPassing {
    var dataStore: ListWeathersDataStore? { get }
    func passDataToWeathersInfo()
}

class ListWeathersRouter: ListWeathersRoutingLogic, ListWeathersDataPassing {
    
    weak var viewController: ListWeathersViewController?
    var dataStore: ListWeathersDataStore?
    
    func routeToMainWeather(selectedCell: Int) {
        let destinationVC = WeathersInfoViewController(startPosition: selectedCell)
        var destinationDS = destinationVC.router!.dataStore!
        passDataToWeathersInfo(source: dataStore!, destination: &destinationDS)
        navigateToWeathersInfo(source: viewController!, destination: destinationVC)
    }
    
    func passDataToWeathersInfo() {
        guard let controllers = viewController?.navigationController?.viewControllers else { return }
        for controller in controllers {
            if let destinationVC = controller as? WeathersInfoViewController {
                var destinationDS = destinationVC.router!.dataStore!
                passDataToWeathersInfo(source: dataStore!, destination: &destinationDS)
                destinationVC.interactor?.fetchWeathers()
            }
        }
    }
    
    func routeToPlaceSearch() {
        let destinationVC = PlaceSearchViewController()
        navigateToPlaceSearch(source: viewController!, destination: destinationVC)
    }
    
    
    func navigateToPlaceSearch(source: ListWeathersViewController, destination: PlaceSearchViewController) {
        source.show(destination, sender: nil)
    }
    
    func navigateToWeathersInfo(source: ListWeathersViewController, destination: WeathersInfoViewController) {
        source.show(destination, sender: nil)
    }
    
    func passDataToWeathersInfo(source: ListWeathersDataStore, destination: inout WeathersInfoDataStore) {
        destination.weathers = source.weathers
    }
}
