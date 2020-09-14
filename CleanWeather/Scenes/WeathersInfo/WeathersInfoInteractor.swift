//
//  WeathersInfoInteractor.swift
//  CleanWeather
//
//  Created by 18592232 on 10.09.2020.
//  Copyright © 2020 18592232. All rights reserved.
//

import Foundation

//    MARK: Protocols

protocol WeathersInfoBusinessLogic {
    func fetchWeathers()
}

protocol WeathersInfoDataStore {
    var weathers: [Weather]? { get set }
}

//    MARK: Interactor

class WeathersInfoInteractor: WeathersInfoBusinessLogic, WeathersInfoDataStore{
    
    var presenter: WeathersInfoPresentationLogic?
    var weathers: [Weather]?
    
//    MARK: Fetching
    
    func fetchWeathers() {
        let response = WeathersInfo.FetchWeathers.Response(weathers: self.weathers!)
        self.presenter?.presentFetchedWeathers(response: response)
    }
}
