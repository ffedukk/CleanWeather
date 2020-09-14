//
//  WeathersInfoRouter.swift
//  CleanWeather
//
//  Created by 18592232 on 11.09.2020.
//  Copyright © 2020 18592232. All rights reserved.
//

import Foundation

protocol WeathersInfoRoutingLogic
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
        guard let controllers = viewController?.navigationController?.viewControllers else { return }
        for controller in controllers {
            if let _ = controller as? ListWeathersViewController {
                viewController?.navigationController?.popViewController(animated: true)
            }
        }
    }
}
