//
//  ListWeathersInteractoTest.swift
//  ListWeathersInteractoTest
//
//  Created by 18592232 on 15.09.2020.
//  Copyright © 2020 18592232. All rights reserved.
//

import XCTest
import CoreData
@testable import CleanWeather

class ListWeathersPresenterSpy: ListWeathersPresentationLogic {
    var presentFetchedWeathersCalled = 0
    func presentFetchedWeathers(response: ListWeathers.FetchWeathers.Response) {
        presentFetchedWeathersCalled += 1
    }
}

class CoreDataWorkerSpy: CoreDataWorkerProtocol {
    let managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    var managedObjects: [NSManagedObject] = []
    
    var fetchCalled = 0
    var addWeatherCalled = 0
    var updateItemCalled = 0
    var deleteFromDataCalled = 0
    
    func fetch(completion: ([ManagedWeather]) -> ()) {
        let managedWeathers = [ManagedWeather.create(weatherData: ["pressure": 1017.0, "name": "Moscow", "tempMin": 290.15, "sunset": 1600184863, "tempMax": 292.04, "weather": "Clouds", "temp": 290.88, "weatherDescription": "Clouds", "sunrise": 1600138909, "windSpeed": 5.0, "feelsLike": 287.59], forecastData: [["date": "2020-09-15 12:00:00", "weather": "Clouds", "temp": 290.31], ["weather": "Clouds", "temp": 288.22, "date": "2020-09-15 15:00:00"]], managedContext: managedObjectContext),ManagedWeather.create(weatherData: ["pressure": 1017.0, "name": "Moscow", "tempMin": 290.15, "sunset": 1600184863, "tempMax": 292.04, "weather": "Clouds", "temp": 290.88, "weatherDescription": "Clouds", "sunrise": 1600138909, "windSpeed": 5.0, "feelsLike": 287.59], forecastData: [["date": "2020-09-15 12:00:00", "weather": "Clouds", "temp": 290.31], ["weather": "Clouds", "temp": 288.22, "date": "2020-09-15 15:00:00"]], managedContext: managedObjectContext)]
        fetchCalled += 1
        completion(managedWeathers)
    }
    
    func add(weatherData: [String : Any], forecastData: [[String : Any]], completion: @escaping (ManagedWeather) -> ()) {
        addWeatherCalled += 1
        let managedWeather = ManagedWeather.create(weatherData: weatherData, forecastData: forecastData, managedContext: managedObjectContext)
        managedObjects.append(managedWeather)
        completion(managedWeather)
    }
    
    func updateItem(weatherData: [String : Any], forecastData: [[String : Any]], at index: Int, completion: (ManagedWeather) -> ()) {
        updateItemCalled += 1
        let managedWeather = ManagedWeather.create(weatherData: weatherData, forecastData: forecastData, managedContext: managedObjectContext)
        completion(managedWeather)
    }
    
    func deleteFromData(at index: Int, completion: () -> ()) {
        managedObjects.remove(at: index)
        deleteFromDataCalled += 1
        completion()
    }
}

class NetworkWorkerSpy: ListWeathersNetworkWorkerProtocol {
    var getWeatherDataCalled = 0
    func getWeatherData(weatherURL: String, forecastURL: String, completion: @escaping ([String : Any], [[String : Any]]) -> ()) {
        getWeatherDataCalled += 1
        completion(["pressure": 1017.0, "name": "Moscow", "tempMin": 290.15, "sunset": 1600184863, "tempMax": 292.04, "weather": "Clouds", "temp": 290.88, "weatherDescription": "Clouds", "sunrise": 1600138909, "windSpeed": 5.0, "feelsLike": 287.59],[["date": "2020-09-15 12:00:00", "weather": "Clouds", "temp": 290.31], ["weather": "Clouds", "temp": 288.22, "date": "2020-09-15 15:00:00"]])
    }
}



class ListWeathersInteractoTest: XCTestCase {
    
    var sut: ListWeathersInteractor!
    var presenter: ListWeathersPresenterSpy!
    var coreDataWorker: CoreDataWorkerSpy!
    var networkWorker: NetworkWorkerSpy!

    override func setUp() {
        sut = ListWeathersInteractor()
        presenter = ListWeathersPresenterSpy()
        coreDataWorker = CoreDataWorkerSpy()
        networkWorker = NetworkWorkerSpy()
        
        sut.presenter = presenter
        sut.coreDataWorker = coreDataWorker
        sut.networkWorker = networkWorker
    }
    
    override func tearDown() {
        sut = nil
        presenter = nil
        coreDataWorker = nil
        networkWorker = nil
    }
    
    func testFetchWeathersFromCoreData() {
        let request = ListWeathers.FetchWeathers.Request()
        
        sut.fetchWeathersFromCoreData(request: request)
        
        XCTAssertEqual(coreDataWorker.fetchCalled, 1, "Not started worker.fetchUsers(:)")
        XCTAssertEqual(presenter.presentFetchedWeathersCalled, 1,  "Not started presenter.presentFetchedWeathers(:)")
        XCTAssertEqual(sut.weathers?.count, 2, "count of item is different")
    }
    
    func testAddWeather() {
        sut.addWeather(place: "moscow")
        
        XCTAssertEqual(networkWorker.getWeatherDataCalled, 1, "Not started networkWorker.getWeatherData(:)")
        XCTAssertEqual(coreDataWorker.addWeatherCalled, 1, "Not started coreDataWorker.add(:)")
        XCTAssertEqual(presenter.presentFetchedWeathersCalled, 1,  "Not started presenter.presentFetchedWeathers(:)")
        XCTAssertEqual(sut.weathers?.count, 1, "count of item is different")
        
        sut.addWeather(place: "moscow")
        XCTAssertEqual(networkWorker.getWeatherDataCalled, 2, "Not started networkWorker.getWeatherData(:)")
        XCTAssertEqual(coreDataWorker.addWeatherCalled, 2, "Not started coreDataWorker.add(:)")
        XCTAssertEqual(presenter.presentFetchedWeathersCalled, 2,  "Not started presenter.presentFetchedWeathers(:)")
        XCTAssertEqual(sut.weathers?.count, 2, "count of item is different")
    }
    
    func testAddWeatherInLocation() {
        sut.weathers = []
        sut.addWeatherInLocation(latitude: "1", longitude: "1")
        
        XCTAssertEqual(networkWorker.getWeatherDataCalled, 1, "Not started networkWorker.getWeatherData(:)")
        XCTAssertEqual(coreDataWorker.addWeatherCalled, 1, "Not started coreDataWorker.add(:)")
        XCTAssertEqual(presenter.presentFetchedWeathersCalled, 1,  "Not started presenter.presentFetchedWeathers(:)")
        XCTAssertEqual(sut.weathers?.count, 1, "count of item after add should be 1")
        
        sut.addWeatherInLocation(latitude: "1", longitude: "1")
        
        XCTAssertEqual(networkWorker.getWeatherDataCalled, 2, "Not started networkWorker.getWeatherData(:)")
        XCTAssertEqual(coreDataWorker.updateItemCalled, 1, "Not started coreDataWorker.updateItem(:)")
        XCTAssertEqual(presenter.presentFetchedWeathersCalled, 2,  "Not started presenter.presentFetchedWeathers(:)")
        XCTAssertEqual(sut.weathers?.count, 1, "count of item after update should be 1")
    }
    
    func testDeleteWeather() {
        sut.addWeather(place: "")
        
        XCTAssertEqual(coreDataWorker.managedObjects.count, 1, "count after add should be 1")
        
        sut.deleteWeather(at: 0)
        
        XCTAssertEqual(coreDataWorker.deleteFromDataCalled, 1, "Not started coreDataWorker.deleteFromData(:)")
        XCTAssertEqual(coreDataWorker.managedObjects.count, 0, "count after delete should be 0")
    }
    

}
