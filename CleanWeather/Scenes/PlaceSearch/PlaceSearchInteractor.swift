//
//  PlaceSearchInteractor.swift
//  CleanWeather
//
//  Created by 18592232 on 13.09.2020.
//  Copyright © 2020 18592232. All rights reserved.
//

import Foundation

//    MARK: Protocols

protocol PlaceSearchBusinessLogic
{
  
}

//    MARK: Interactor

class PlaceSearchInteractor: PlaceSearchBusinessLogic {
    
    var presenter: PlaceSearchPresentationLogic?
    var networkWorker = PlaceSearchNetworkWorker()
    
    var weathers: [Weather]?
}
