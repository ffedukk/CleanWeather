//
//  JSONForecastParserTests.swift
//  CleanWeatherTests
//
//  Created by 18592232 on 18.09.2020.
//  Copyright © 2020 18592232. All rights reserved.
//

import XCTest
@testable import CleanWeather

class JSONForecastParserTests: XCTestCase {

    var sut: JSONForecastParser!
    
    override func setUp() {
        sut = JSONForecastParser()
    }

    override func tearDown() {
        sut = nil
    }

    func testPassingValidData() {
        let testBundle = Bundle(for: type(of: self))
        let path = testBundle.path(forResource: "ForecastValidData", ofType: "json")
        let data = try! Data(contentsOf: URL(fileURLWithPath: path!), options: .alwaysMapped)
        XCTAssertEqual(sut.parse(data)?.count, 40, "Prediction Parser didnt parse")
    }

    func testPassingInvalidFormat() {
        let testBundle = Bundle(for: type(of: self))
        let path = testBundle.path(forResource: "ForecastInvalidFormat", ofType: "txt")
        let data = try! Data(contentsOf: URL(fileURLWithPath: path!), options: .alwaysMapped)
        XCTAssertNil(sut.parse(data), "Forecast Parser parse invalid format")
    }
    
    func testPassingInvalidData() {
        let testBundle = Bundle(for: type(of: self))
        let path = testBundle.path(forResource: "ForecastInvalidData", ofType: "json")
        let data = try! Data(contentsOf: URL(fileURLWithPath: path!), options: .alwaysMapped)
        XCTAssertNil(sut.parse(data), "Forecast Parser parse invalid data")
    }

}
