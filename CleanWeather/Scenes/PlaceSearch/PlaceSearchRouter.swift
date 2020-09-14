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
    func routeToListWeathers(with passedData: String?)
}

class PlaceSearchRouter: PlaceSearchRoutingLogic
{
    weak var viewController: PlaceSearchViewController?
    
    func routeToListWeathers(with passedData: String?) {
        guard let controllers = viewController?.navigationController?.viewControllers else { return }
        for controller in controllers {
            if let destinationVC = controller as? ListWeathersViewController {
                if let passedData = passedData {
                    destinationVC.interactor?.addWeather(place: passedData)
                }
                viewController?.navigationController?.popViewController(animated: true)
            }
        }
    }
}
