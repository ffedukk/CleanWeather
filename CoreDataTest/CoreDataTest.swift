//
//  CoreDataTest.swift
//  CoreDataTest
//
//  Created by 18592232 on 15.09.2020.
//  Copyright © 2020 18592232. All rights reserved.
//

import XCTest
import CoreData
@testable import CleanWeather

class DataManager {
    var managedObjectContext: NSManagedObjectContext!
}

class CoreDataTest: XCTestCase {
    
    var sut: CoreDataWorker!
    var managedObjectContext: NSManagedObjectContext!

    override func setUp() {
        sut = CoreDataWorker()
        managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    }
    
    override func tearDown() {
        sut = nil
        managedObjectContext = nil
    }
    
    func testExample() {
        let initialCount = try! sut.coreDataManager?.persistentContainer.viewContext.count(for: NSFetchRequest<NSManagedObject>(entityName: "ManagedWeather"))
        sut.add(weatherData: ["pressure": 1017.0, "name": "Moscow", "tempMin": 290.15, "sunset": 1600184863, "tempMax": 292.04, "weather": "Clouds", "temp": 290.88, "weatherDescription": "Clouds", "sunrise": 1600138909, "windSpeed": 5.0, "feelsLike": 287.59], forecastData: [["date": "2020-09-15 12:00:00", "weather": "Clouds", "temp": 290.31], ["weather": "Clouds", "temp": 288.22, "date": "2020-09-15 15:00:00"]]) { (managedWeather) in
            let finalCount = try! self.sut.coreDataManager?.persistentContainer.viewContext.count(for: NSFetchRequest<NSManagedObject>(entityName: "ManagedWeather"))
            XCTAssertEqual(initialCount! + 1, finalCount!, "adding object failed")
        }
        
        sut.deleteFromData(at: 0) {
            let finalCount = try! self.sut.coreDataManager?.persistentContainer.viewContext.count(for: NSFetchRequest<NSManagedObject>(entityName: "ManagedWeather"))
            XCTAssertEqual(initialCount!, finalCount!, "deleting object failed")
        }
    }
}
