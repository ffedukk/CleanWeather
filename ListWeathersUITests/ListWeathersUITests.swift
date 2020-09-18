//
//  ListWeathersUITests.swift
//  ListWeathersUITests
//
//  Created by 18592232 on 18.09.2020.
//  Copyright © 2020 18592232. All rights reserved.
//

import XCTest

class ListWeathersUITests: XCTestCase {

    var app: XCUIApplication!
    
    override func setUp() {
      app = XCUIApplication()
      app.launch()
    }

    func testExample() throws {
                // UI tests must launch the application that they test.
        //app.launch()
        
        let collectionViewsQuery = XCUIApplication().collectionViews
        
        let deleteButton = collectionViewsQuery/*@START_MENU_TOKEN@*/.buttons["More Info"]/*[[".cells.buttons[\"More Info\"]",".buttons[\"More Info\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        let editButton = collectionViewsQuery/*@START_MENU_TOKEN@*/.buttons["Edit"]/*[[".cells.buttons[\"Edit\"]",".buttons[\"Edit\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        let addButton = collectionViewsQuery/*@START_MENU_TOKEN@*/.buttons["plus.circle"]/*[[".cells.buttons[\"plus.circle\"]",".buttons[\"plus.circle\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        let location = XCUIApplication().collectionViews/*@START_MENU_TOKEN@*/.staticTexts["San Francisco"]/*[[".cells.staticTexts[\"San Francisco\"]",".staticTexts[\"San Francisco\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
       
        XCTAssertTrue(deleteButton.exists)
        XCTAssertTrue(editButton.exists)
        XCTAssertTrue(addButton.exists)
        XCTAssertTrue(location.exists)
        
        
        location.tap()
        
        
        let collectionViewsQuery2 = XCUIApplication().collectionViews
        let placeName = collectionViewsQuery2/*@START_MENU_TOKEN@*/.collectionViews.staticTexts["San Francisco"]/*[[".cells.collectionViews",".cells.staticTexts[\"San Francisco\"]",".staticTexts[\"San Francisco\"]",".collectionViews"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/
        let sunrise = collectionViewsQuery2/*@START_MENU_TOKEN@*/.collectionViews.staticTexts["Sunrise"]/*[[".cells.collectionViews",".cells.staticTexts[\"Sunrise\"]",".staticTexts[\"Sunrise\"]",".collectionViews"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/
        let sunset = collectionViewsQuery2/*@START_MENU_TOKEN@*/.collectionViews.staticTexts["Sunset"]/*[[".cells.collectionViews",".cells.staticTexts[\"Sunset\"]",".staticTexts[\"Sunset\"]",".collectionViews"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/
        let windSpeed = collectionViewsQuery2/*@START_MENU_TOKEN@*/.collectionViews.staticTexts["Wind Speed"]/*[[".cells.collectionViews",".cells.staticTexts[\"Wind Speed\"]",".staticTexts[\"Wind Speed\"]",".collectionViews"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/
        let feelsLike = collectionViewsQuery2/*@START_MENU_TOKEN@*/.collectionViews.staticTexts["Feels Like"]/*[[".cells.collectionViews",".cells.staticTexts[\"Feels Like\"]",".staticTexts[\"Feels Like\"]",".collectionViews"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/
        let pressure = collectionViewsQuery2/*@START_MENU_TOKEN@*/.collectionViews.staticTexts["Pressure"]/*[[".cells.collectionViews",".cells.staticTexts[\"Pressure\"]",".staticTexts[\"Pressure\"]",".collectionViews"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/
        
        XCTAssertTrue(placeName.exists)
        XCTAssertTrue(sunrise.exists)
        XCTAssertTrue(sunset.exists)
        XCTAssertTrue(windSpeed.exists)
        XCTAssertTrue(feelsLike.exists)
        XCTAssertTrue(pressure.exists)
       
        XCUIApplication().navigationBars["CleanWeather.WeathersInfoView"].buttons["Back"].tap()
        
        XCTAssertFalse(placeName.exists)
        XCTAssertFalse(sunrise.exists)
        XCTAssertFalse(sunset.exists)
        XCTAssertFalse(windSpeed.exists)
        XCTAssertFalse(feelsLike.exists)
        XCTAssertFalse(pressure.exists)
        
        app.collectionViews/*@START_MENU_TOKEN@*/.buttons["plus.circle"]/*[[".cells.buttons[\"plus.circle\"]",".buttons[\"plus.circle\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let searchField = app.searchFields["Search"]
        let cancelButton = app/*@START_MENU_TOKEN@*/.buttons["Cancel"].staticTexts["Cancel"]/*[[".buttons[\"Cancel\"].staticTexts[\"Cancel\"]",".staticTexts[\"Cancel\"]"],[[[-1,1],[-1,0]]],[1]]@END_MENU_TOKEN@*/
        XCTAssertTrue(searchField.exists)
        XCTAssertTrue(cancelButton.exists)
        
        cancelButton.tap()
        XCTAssertFalse(searchField.exists)
        XCTAssertFalse(cancelButton.exists)
        
        app.collectionViews/*@START_MENU_TOKEN@*/.buttons["plus.circle"]/*[[".cells.buttons[\"plus.circle\"]",".buttons[\"plus.circle\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        XCTAssertTrue(searchField.exists)
        XCTAssertTrue(cancelButton.exists)
        
        app.navigationBars["CleanWeather.PlaceSearchView"].buttons["Back"].tap()
        XCTAssertFalse(searchField.exists)
        XCTAssertFalse(cancelButton.exists)
        
        app.collectionViews/*@START_MENU_TOKEN@*/.buttons["plus.circle"]/*[[".cells.buttons[\"plus.circle\"]",".buttons[\"plus.circle\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        let aKey = app/*@START_MENU_TOKEN@*/.keys["A"]/*[[".keyboards.keys[\"A\"]",".keys[\"A\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        aKey.tap()
        let prediction = app.tables/*@START_MENU_TOKEN@*/.staticTexts["Area 51, NV, USA"]/*[[".cells.staticTexts[\"Area 51, NV, USA\"]",".staticTexts[\"Area 51, NV, USA\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        XCTAssertTrue(prediction.exists)
        prediction.tap()
        XCTAssertFalse(prediction.exists)
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
}
