//
//  WeathersInfoViewControllerTests.swift
//  WeathersInfoViewControllerTests
//
//  Created by 18592232 on 18.09.2020.
//  Copyright © 2020 18592232. All rights reserved.
//

import XCTest
@testable import CleanWeather

class WeathersInfoInteractorSpy: WeathersInfoBusinessLogic, WeathersInfoDataStore {
    var fetchWeathersCalled = 0
    
    func fetchWeathers() {
        fetchWeathersCalled += 1
    }
    
    var weathers: [Weather]?
}

class WeathersInfoRouterSpy: WeathersInfoDataPassing {
    var dataStore: WeathersInfoDataStore?
}

class WeathersInfoViewControllerTests: XCTestCase {

    var sut: WeathersInfoViewController!
    var interactor: WeathersInfoInteractorSpy!
    var router: WeathersInfoRouterSpy!
    
    override func setUp() {
        sut = WeathersInfoViewController(startPosition: 0)
        interactor = WeathersInfoInteractorSpy()
        router = WeathersInfoRouterSpy()
        
        sut.interactor = interactor
        sut.router = router
        
        sut.loadViewIfNeeded()
    }
    
    override func tearDown() {
        sut = nil
        interactor = nil
        router = nil

    }
}
