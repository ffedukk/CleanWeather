//
//  CoreDataTests.swift
//  CoreDataTest
//
//  Created by 18592232 on 18.09.2020.
//  Copyright © 2020 18592232. All rights reserved.
//

import XCTest
import CoreData
@testable import CleanWeather

class MocCoreDataManager: CoreDataManagerProtocol {
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CleanWeather")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    func saveContext () {
    }
}

class CoreDataTests: XCTestCase {

    var sut: CoreDataWorker!
    var coreDataManager: MocCoreDataManager!

    override func setUp() {
        sut = CoreDataWorker()
        coreDataManager = MocCoreDataManager()
        sut.coreDataManager = coreDataManager
    }
    
    override func tearDown() {
        sut = nil
        coreDataManager = nil
    }
    
    func testAddDelete() {
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
