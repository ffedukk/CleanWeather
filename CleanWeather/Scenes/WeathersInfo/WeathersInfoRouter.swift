//
//  WeathersInfoRouter.swift
//  CleanWeather
//
//  Created by 18592232 on 11.09.2020.
//  Copyright © 2020 18592232. All rights reserved.
//

import Foundation

protocol WeathersInfoDataPassing {
    var dataStore: WeathersInfoDataStore? { get }
}

class WeathersInfoRouter: WeathersInfoDataPassing {
    weak var viewController: WeathersInfoViewController?
    var dataStore: WeathersInfoDataStore?
}
