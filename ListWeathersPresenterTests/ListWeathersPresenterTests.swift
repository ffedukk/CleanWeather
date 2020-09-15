//
//  ListWeathersPresenterTests.swift
//  ListWeathersPresenterTests
//
//  Created by 18592232 on 15.09.2020.
//  Copyright © 2020 18592232. All rights reserved.
//

import XCTest
@testable import CleanWeather

class ListWeathersViewControllerSpy: ListWeathersDisplayLogic {
    var displayFetchedWeathersCalled = 0
    func displayFetchedWeathers(viewModel: ListWeathers.FetchWeathers.ViewModel) {
        displayFetchedWeathersCalled += 1
    }
}

class ListWeathersPresenterTests: XCTestCase {

    var sut: ListWeathersPresenter!
    var viewController: ListWeathersViewControllerSpy!
    
    override func setUp() {
        sut = ListWeathersPresenter()
        viewController = ListWeathersViewControllerSpy()
        sut.viewController = viewController
    }
    
    override func tearDown() {
        sut = nil
        viewController = nil
    }
    
    func testPresentFetchedWeathers() {
        let response = ListWeathers.FetchWeathers.Response(weathers: [])
        
        sut.presentFetchedWeathers(response: response)
        
        XCTAssertEqual(viewController.displayFetchedWeathersCalled, 1, "Not started viewController.displayFetchedWeathers(:)")
    }

}
