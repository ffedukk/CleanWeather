//
//  WeathersInfoPresenterTests.swift
//  WeathersInfoPresenterTests
//
//  Created by 18592232 on 15.09.2020.
//  Copyright © 2020 18592232. All rights reserved.
//

import XCTest
@testable import CleanWeather

class WeathersInfoViewControllerSpy: WeathersInfoDisplayLogic {
    
    var displayFetchedWeathersCalled = 0
    
    func displayFetchedWeathers(viewModel: WeathersInfo.FetchWeathers.ViewModel) {
        displayFetchedWeathersCalled += 1
    }
}

class WeathersInfoPresenterTests: XCTestCase {
    
    var sut: WeathersInfoPresenter!
    var viewConroller: WeathersInfoViewControllerSpy!

    override func setUp() {
        sut = WeathersInfoPresenter()
        viewConroller = WeathersInfoViewControllerSpy()
        sut.viewController = viewConroller
    }
    
    override func tearDown() {
        sut = nil
        viewConroller = nil
    }
    
    func testPresentFetchedWeathers() {
        let forecast = Weather.Forecast(time: " 11:00    ", temperature: 0, icon: "")
        let weather = Weather(feelsLike: 0, placeName: "", pressure: 0, sunrise: 0, sunset: 0, temperature: 0, temperatureMax: 0, temperatureMin: 0, icon: "", weatherDescription: "", windSpeed: 0, forecastList: [forecast])
        let response = WeathersInfo.FetchWeathers.Response(weathers: [weather])
        sut.presentFetchedWeathers(response: response)
        XCTAssertEqual(viewConroller.displayFetchedWeathersCalled, 1, "Not started viewController.displayFetchedWeathers(:)")
    }
    

}
