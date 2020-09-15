//
//  ListWeathersViewControllerTests.swift
//  ListWeathersViewControllerTests
//
//  Created by 18592232 on 15.09.2020.
//  Copyright © 2020 18592232. All rights reserved.
//


import XCTest
@testable import CleanWeather

class MocListWeathersInteractor: ListWeathersInteractor {
    var dataFetchedFromCoreData = 0
    var dataUpdated = 0
    var weatherAdded = 0
    override func fetchWeathersFromCoreData(request: ListWeathers.FetchWeathers.Request) {
        dataFetchedFromCoreData += 1
    }
    override func updateWeathers() {
        dataUpdated += 1
    }
    override func addWeather(place: String) {
        weatherAdded += 1
    }
}

class ListWeathersViewControllerTests: XCTestCase {

    var sut: ListWeathersViewController!
    var mocListWeathersInteractor: MocListWeathersInteractor!
    
    override func setUp() {
        sut = ListWeathersViewController()
        mocListWeathersInteractor = MocListWeathersInteractor()
        sut.interactor = mocListWeathersInteractor
        sut.loadViewIfNeeded()
    }
    
    override func tearDown() {
        sut = nil
        mocListWeathersInteractor = nil
    }
    
    func testFetchWeathersFromCoreDataTriggered() {
        XCTAssertEqual(mocListWeathersInteractor.dataFetchedFromCoreData, 0, "dataFetchedFromCoreData should be 0 before ViewDidLoad")
        XCTAssertEqual(mocListWeathersInteractor.dataUpdated, 0, "dataUpdated should be 0 before ViewDidLoad")
        sut.viewDidLoad()
        XCTAssertEqual(mocListWeathersInteractor.dataFetchedFromCoreData, 1, "fetchDataFromCoreData Shouls be triggered only once")
        XCTAssertEqual(mocListWeathersInteractor.dataUpdated, 1, "updateData Shouls be triggered only once")
    }
    
    func testAddWeatherTriggered() {
        XCTAssertEqual(mocListWeathersInteractor.dataUpdated, 0, "addWeather Shouls be 0 before AddButtonPressed")
        sut.viewDidLoad()
        sut.addButtonPressed()
        XCTAssertEqual(mocListWeathersInteractor.dataUpdated, 1, "addWeather Shouls be triggered only once")
    }
}
