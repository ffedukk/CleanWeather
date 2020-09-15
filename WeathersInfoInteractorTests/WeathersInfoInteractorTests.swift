//
//  WeathersInfoInteractorTests.swift
//  WeathersInfoInteractorTests
//
//  Created by 18592232 on 15.09.2020.
//  Copyright © 2020 18592232. All rights reserved.
//

import XCTest
@testable import CleanWeather

class WeathersInfoPresenterSpy: WeathersInfoPresentationLogic {
    
    var presentFetchedWeathersCalled = 0
    
    func presentFetchedWeathers(response: WeathersInfo.FetchWeathers.Response) {
        presentFetchedWeathersCalled += 1
    }
}

class WeathersInfoInteractorTests: XCTestCase {
    
    var sut: WeathersInfoInteractor!
    var presenter: WeathersInfoPresenterSpy!

    override func setUp() {
        sut = WeathersInfoInteractor()
        presenter = WeathersInfoPresenterSpy()
        
        sut.presenter = presenter
    }
    
    override func tearDown() {
        sut = nil
        presenter = nil
    }
    
    func testFetchWeathers() {
        sut.weathers = []
        sut.fetchWeathers()
        XCTAssertEqual(presenter.presentFetchedWeathersCalled, 1, "Not started presenter.presentFetchedWeathers(:)")
    }
}
