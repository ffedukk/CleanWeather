//
//  CleanWeatherTests.swift
//  CleanWeatherTests
//
//  Created by 18592232 on 14.09.2020.
//  Copyright © 2020 18592232. All rights reserved.
//

import XCTest
@testable import CleanWeather

class JSONPredictionParserTests: XCTestCase {
    
    var sut: JSONPredictionParser!
    
    override func setUp() {
        sut = JSONPredictionParser()
    }

    override func tearDown() {
        sut = nil
    }

    func testPassingValidData() {
        let testBundle = Bundle(for: type(of: self))
        let path = testBundle.path(forResource: "predictionValidData", ofType: "json")
        let data = try! Data(contentsOf: URL(fileURLWithPath: path!), options: .alwaysMapped)
        XCTAssertEqual(sut.parse(data)?.count, 5, "Prediction Parser didnt parse")
    }

    func testPassingInvalidFormat() {
        let testBundle = Bundle(for: type(of: self))
        let path = testBundle.path(forResource: "predictionInvalidFormat", ofType: "txt")
        let data = try! Data(contentsOf: URL(fileURLWithPath: path!), options: .alwaysMapped)
        XCTAssertNil(sut.parse(data), "Prediction Parser parse invalid format")
    }
    
    func testPassingInvalidData() {
        let testBundle = Bundle(for: type(of: self))
        let path = testBundle.path(forResource: "predictionInvalidData", ofType: "json")
        let data = try! Data(contentsOf: URL(fileURLWithPath: path!), options: .alwaysMapped)
        XCTAssertNil(sut.parse(data), "Prediction Parser parse invalid format")
    }
}
