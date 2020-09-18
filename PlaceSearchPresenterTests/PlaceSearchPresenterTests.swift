//
//  PlaceSearchPresenterTests.swift
//  PlaceSearchPresenterTests
//
//  Created by 18592232 on 18.09.2020.
//  Copyright © 2020 18592232. All rights reserved.
//

import XCTest
@testable import CleanWeather

class PlaceSearchViewControllerSpy: PlaceSearchDisplayLogic {
    var displayFetchedSearchResultsCalled = 0
    
    func displayFetchedSearchResults(viewModel: PlaceSearch.FetchPlaces.ViewModel) {
        displayFetchedSearchResultsCalled += 1
    }
}

class PlaceSearchPresenterTests: XCTestCase {

    var sut: PlaceSearchPresenter!
    var viewController: PlaceSearchViewControllerSpy!
    
    override func setUp() {
        sut = PlaceSearchPresenter()
        viewController = PlaceSearchViewControllerSpy()
        
        sut.viewController = viewController
    }
    
    override func tearDown() {
        sut = nil
        viewController = nil
    }
    
    func testPresentFetchedPlaces() {
        let place = PlaceSearch.FetchPlaces.Place(adress: "adress")
        sut.presentFetchedPlaces(response: PlaceSearch.FetchPlaces.Response(places: [place, place]))
        
        XCTAssertEqual(viewController.displayFetchedSearchResultsCalled, 1, "Not started viewController.displayFetchedSearchResults(:)")
    }
}
