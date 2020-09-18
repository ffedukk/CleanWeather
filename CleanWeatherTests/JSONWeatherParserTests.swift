//
//  JSONWeatherParserTests.swift
//  CleanWeatherTests
//
//  Created by 18592232 on 18.09.2020.
//  Copyright © 2020 18592232. All rights reserved.
//

import XCTest
@testable import CleanWeather

class JSONWeatherParserTests: XCTestCase {

    var sut: JSONWeatherParser!
    
    override func setUp() {
        sut = JSONWeatherParser()
    }

    override func tearDown() {
        sut = nil
    }

    func testPassingValidData() {
        let testBundle = Bundle(for: type(of: self))
        let path = testBundle.path(forResource: "WeatherValidData", ofType: "json")
        let data = try! Data(contentsOf: URL(fileURLWithPath: path!), options: .alwaysMapped)
        XCTAssertEqual(sut.parse(data)?.count, 11, "Weather Parser didnt parse")
    }

    func testPassingInvalidFormat() {
        let testBundle = Bundle(for: type(of: self))
        let path = testBundle.path(forResource: "WeatherInvalidFormat", ofType: "txt")
        let data = try! Data(contentsOf: URL(fileURLWithPath: path!), options: .alwaysMapped)
        XCTAssertNil(sut.parse(data), "Prediction Parser parse invalid format")
    }
    
    func testPassingInvalidData() {
        let testBundle = Bundle(for: type(of: self))
        let path = testBundle.path(forResource: "WeatherInvalidData", ofType: "json")
        let data = try! Data(contentsOf: URL(fileURLWithPath: path!), options: .alwaysMapped)
        XCTAssertNil(sut.parse(data), "Prediction Parser parse invalid data")
    }

}
