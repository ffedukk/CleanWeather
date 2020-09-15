//
//  NetworkTests.swift
//  NetworkTests
//
//  Created by 18592232 on 14.09.2020.
//  Copyright © 2020 18592232. All rights reserved.
//

import XCTest
@testable import CleanWeather

class NetworkTests: XCTestCase {

    var sut: URLSession!
    
    override func setUp() {
        sut = URLSession(configuration: .default)
    }
    
    override func tearDown() {
        sut = nil
    }
    
    func testCallToWeatherAPICompletes() {
      // given
      let url =
        URL(string: "http://api.openweathermap.org/data/2.5/weather?q=moscow&appid=5a952ad407d71e0b6b47ed1b151907ad")
      let promise = expectation(description: "Completion handler invoked")
      var statusCode: Int?
      var responseError: Error?

      // when
      let dataTask = sut.dataTask(with: url!) { data, response, error in
        statusCode = (response as? HTTPURLResponse)?.statusCode
        responseError = error
        promise.fulfill()
      }
      dataTask.resume()
      wait(for: [promise], timeout: 5)

      // then
      XCTAssertNil(responseError)
      XCTAssertEqual(statusCode, 200)
    }
    
    func testCallToForecastAPICompletes() {
      // given
      let url =
        URL(string: "http://api.openweathermap.org/data/2.5/forecast?q=moscow&appid=5a952ad407d71e0b6b47ed1b151907ad")
      let promise = expectation(description: "Completion handler invoked")
      var statusCode: Int?
      var responseError: Error?

      // when
      let dataTask = sut.dataTask(with: url!) { data, response, error in
        statusCode = (response as? HTTPURLResponse)?.statusCode
        responseError = error
        promise.fulfill()
      }
      dataTask.resume()
      wait(for: [promise], timeout: 5)

      // then
      XCTAssertNil(responseError)
      XCTAssertEqual(statusCode, 200)
    }
    
    func testCallToGoogleAPICompletes() {
      // given
      let url =
        URL(string: "https://maps.googleapis.com/maps/api/place/autocomplete/json?location&input=m&key=AIzaSyB-WCi6uqb7GOqONUocRT4cufVtrCm7Mm8&language=en")
      let promise = expectation(description: "Completion handler invoked")
      var statusCode: Int?
      var responseError: Error?

      // when
      let dataTask = sut.dataTask(with: url!) { data, response, error in
        statusCode = (response as? HTTPURLResponse)?.statusCode
        responseError = error
        promise.fulfill()
      }
      dataTask.resume()
      wait(for: [promise], timeout: 5)

      // then
      XCTAssertNil(responseError)
      XCTAssertEqual(statusCode, 200)
    }

}
