//
//  NetworkReturnTypeTests.swift
//  NetworkTests
//
//  Created by 18592232 on 15.09.2020.
//  Copyright © 2020 18592232. All rights reserved.
//

import XCTest
@testable import CleanWeather

class MocParser: ParserProtocol {
    func parse(_ data: Data) -> [String]? {
        return nil
    }
}

class NetworkReturnTypeTests: XCTestCase {
    
    var sut: NetworkManager!
    var mocParser: MocParser!
    
    override func setUp() {
        sut = NetworkManager()
        mocParser = MocParser()
    }
    
    override func tearDown() {
        sut = nil
        mocParser = nil
    }
    
    func testThrowError() {
        let promise = expectation(description: "Error accured")
        let url = URL(string: "d")
        sut.fetchResult(url: url!, parser: JSONWeatherParser()) { (result) in
            switch result {
            case .failure(let error):
                XCTAssertEqual(error.localizedDescription, "unsupported URL", "Unsupported URL was Supported")
                promise.fulfill()
            case .success(_):
                XCTFail()
            }
        }
        wait(for: [promise], timeout: 1)
    }
    
    func testThrowParserError() {
        let promise = expectation(description: "Error accured")
        let url = URL(string: "http://api.openweathermap.org/data/2.5/weather?q=moscow&appid=5a952ad407d71e0b6b47ed1b151907ad")
        sut.fetchResult(url: url!, parser: mocParser) { (result) in
            switch result {
            case .failure(let error):
                XCTAssertEqual(error.localizedDescription, NetworkManager.networkError.ParseError.localizedDescription, "ParseError wasnt Accured")
                promise.fulfill()
            case .success(_):
                XCTFail()
            }
        }
        wait(for: [promise], timeout: 1)
    }
}
