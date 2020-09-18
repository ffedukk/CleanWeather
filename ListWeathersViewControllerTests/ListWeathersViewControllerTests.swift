//
//  ListWeathersViewControllerTests.swift
//  ListWeathersViewControllerTests
//
//  Created by 18592232 on 15.09.2020.
//  Copyright © 2020 18592232. All rights reserved.
//


import XCTest
@testable import CleanWeather

class ListWeathersInteractorSpy: ListWeathersBusinessLogic, ListWeathersDataStore {
    
    var weathers: [Weather]? = []
    
    var dataFetchedFromCoreDataCalled = 0
    var dataUpdatedCalled = 0
    var weatherAddedCalled = 0
    var deleteWeatherCalled = 0
    
    func fetchWeathersFromCoreData(request: ListWeathers.FetchWeathers.Request) {
        dataFetchedFromCoreDataCalled += 1
    }
    
    func updateWeathers() {
        dataUpdatedCalled += 1
    }
    
    func addWeather(place: String) {
        weatherAddedCalled += 1
    }
    
    func deleteWeather(at index: Int) {
        deleteWeatherCalled += 1
    }
}

class ListWeathersRouterSpy: ListWeathersRoutingLogic, ListWeathersDataPassing {
    var dataStore: ListWeathersDataStore?
    
    var routeToMainWeatherCalled = 0
    var routeToPlaceSearchCalled = 0
    var passDataToWeathersInfoCalled = 0
    
    func routeToMainWeather(selectedCell: Int) {
        routeToMainWeatherCalled += 1
    }
    
    func routeToPlaceSearch() {
        routeToPlaceSearchCalled += 1
    }
    
    func passDataToWeathersInfo() {
        passDataToWeathersInfoCalled += 1
    }
}

class ListWeathersViewControllerTests: XCTestCase {

    var sut: ListWeathersViewController!
    var interactor: ListWeathersInteractorSpy!
    var router: ListWeathersRouterSpy!
    
    override func setUp() {
        sut = ListWeathersViewController()
        interactor = ListWeathersInteractorSpy()
        router = ListWeathersRouterSpy()
        sut.interactor = interactor
        sut.router = router
        sut.loadViewIfNeeded()
    }
    
    override func tearDown() {
        sut = nil
        interactor = nil
        router = nil
    }
    
    func testTimer() {
        XCTAssertEqual(router.passDataToWeathersInfoCalled, 0, "passDataToWeathersInfo should be 0 before ViewDidLoad")
        sut.viewDidLoad()
        let promise = expectation(description: "timer called")
        DispatchQueue.global().async {
            sleep(15)
            promise.fulfill()
        }
        wait(for: [promise], timeout: 20)
        XCTAssertEqual(interactor.dataFetchedFromCoreDataCalled, 1, "fetchDataFromCoreData Shouls be triggered only once")
        XCTAssertEqual(interactor.dataUpdatedCalled, 2, "updateData Shouls be triggered twice")
        XCTAssertEqual(router.passDataToWeathersInfoCalled, 1, "passDataToWeathersInfo should be triggered only once")
    }
    
    func testFetchWeathersFromCoreDataTriggered() {
        XCTAssertEqual(interactor.dataFetchedFromCoreDataCalled, 0, "dataFetchedFromCoreData should be 0 before ViewDidLoad")
        XCTAssertEqual(interactor.dataUpdatedCalled, 0, "dataUpdated should be 0 before ViewDidLoad")
        sut.viewDidLoad()
        XCTAssertEqual(interactor.dataFetchedFromCoreDataCalled, 1, "fetchDataFromCoreData Shouls be triggered only once")
        XCTAssertEqual(interactor.dataUpdatedCalled, 1, "updateData Shouls be triggered only once")
    }
    
    func testAddButtonPressed() {
        sut.viewDidLoad()
        sut.addButtonPressed()
        XCTAssertEqual(router.routeToPlaceSearchCalled, 1, "Not started router.routeToPlaceSearch()")
    }
    
    func testEditButtonPressed() {
        sut.viewDidLoad()
        XCTAssertFalse(sut.isEditing, "Edit Mode initialy false")
        sut.editButtonPressed()
        XCTAssertTrue(sut.isEditing, "Edit Mode wasnt changed")
        sut.editButtonPressed()
        XCTAssertFalse(sut.isEditing, "Edit Mode wasnt changed")
    }
    
    func testDeleteButtonPressed() {
        sut.viewDidLoad()
        let item = ListWeathers.FetchWeathers.ViewModel.DisplayedWeather(placeName: "d", icon: "d", temperature: "e")
        
        sut.displayedItems = [item,item,item]
        sut.collectionView.reloadData()
        sut.collectionView.selectItem(at: IndexPath(item: 1, section: 0), animated: false, scrollPosition: .centeredHorizontally)
        sut.deleteButtonPressed()
        XCTAssertEqual(interactor.deleteWeatherCalled, 1, "Not started interactor.deleteWeather()")
        
        sut.isEditing = true
        sut.displayedItems = [item]
        sut.collectionView.reloadData()
        sut.collectionView.selectItem(at: IndexPath(item: 0, section: 0), animated: false, scrollPosition: .centeredHorizontally)
        sut.deleteButtonPressed()
        XCTAssertFalse(sut.isEditing, "Edit Mode wasnt changed")
    }
    
    
}
