//
//  PlaceSearchInteractorTests.swift
//  PlaceSearchInteractorTests
//
//  Created by 18592232 on 18.09.2020.
//  Copyright © 2020 18592232. All rights reserved.
//

import XCTest
@testable import CleanWeather

class PlaceSearchPresenterSpy: PlaceSearchPresentationLogic {
    var presentFetchedPlacesCalled = 0
    var count = 0
    
    func presentFetchedPlaces(response: PlaceSearch.FetchPlaces.Response) {
        presentFetchedPlacesCalled += 1
        count = response.places.count
    }
}

class NetworkWorkerSpy: PlaceSearchNetworkWorkerProtocol {
    var getTownPredictionCalled = 0
    func getTownPrediction(prediction: String, comletion: @escaping ([String]) -> ()) {
        getTownPredictionCalled += 1
        comletion(["q","e"])
    }
}

class PlaceSearchInteractorTests: XCTestCase {

    var sut: PlaceSearchInteractor!
    var presenter: PlaceSearchPresenterSpy!
    var networkWorker: NetworkWorkerSpy!
    
    override func setUp() {
        sut = PlaceSearchInteractor()
        presenter = PlaceSearchPresenterSpy()
        networkWorker = NetworkWorkerSpy()
        
        sut.networkWorker = networkWorker
        sut.presenter = presenter
    }

    override func tearDown() {
        sut = nil
        presenter = nil
    }
    
    func testFetchSearchResults() {
        sut.fetchSearchResults(prediction: "moscow")
        
        XCTAssertEqual(networkWorker.getTownPredictionCalled, 1, "Not started networkWorker.getTownPrediction(:)")
        XCTAssertEqual(presenter.presentFetchedPlacesCalled, 1, "Not started presenter.presentFetchedPlaces(:)")
    }
    
    func testFetchSearchResultsWithEmptyPrediction() {
        sut.fetchSearchResults(prediction: "")
        
        XCTAssertEqual(networkWorker.getTownPredictionCalled, 0, "Started networkWorker.getTownPrediction(:)")
        XCTAssertEqual(presenter.presentFetchedPlacesCalled, 1, "Not started presenter.presentFetchedPlaces(:)")
    }
    
    func testCountOfPredictions() {
        sut.networkWorker = PlaceSearchNetworkWorker()
        sut.fetchSearchResults(prediction: "moscow")
        
        let promise = expectation(description: "")
        
        DispatchQueue.global().async {
            sleep(5)
            promise.fulfill()
        }
        wait(for: [promise], timeout: 6)
        XCTAssertEqual(presenter.count, 5)
    }
    
    func testCountOfZeroPredictions() {
        sut.networkWorker = PlaceSearchNetworkWorker()
        sut.fetchSearchResults(prediction: "")
        
        let promise = expectation(description: "")
        
        DispatchQueue.global().async {
            sleep(5)
            promise.fulfill()
        }
        wait(for: [promise], timeout: 6)
        XCTAssertEqual(presenter.count, 0)
    }
}
