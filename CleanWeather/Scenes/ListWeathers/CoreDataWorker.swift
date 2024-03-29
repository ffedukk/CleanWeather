//
//  ListWeathersWorker.swift
//  CleanWeather
//
//  Created by 18592232 on 06.09.2020.
//  Copyright © 2020 18592232. All rights reserved.
//

import UIKit
import CoreData

protocol CoreDataWorkerProtocol {
    func add(weatherData: [String:Any], forecastData: [[String:Any]], completion: @escaping (ManagedWeather) -> ())
    func fetch(completion: ([ManagedWeather]) -> ())
    func deleteFromData(at index: Int, completion: () -> ())
    func updateItem(weatherData: [String:Any], forecastData: [[String:Any]], at index: Int, completion: (ManagedWeather) -> ())
}

class CoreDataWorker: CoreDataWorkerProtocol {
    
    weak var coreDataManager: CoreDataManagerProtocol? = (UIApplication.shared.delegate as! AppDelegate).coreDataManager
    
    var managedObjects: [NSManagedObject] = []
    
//    MARK: Adding
    
    func add(weatherData: [String:Any], forecastData: [[String:Any]], completion: @escaping (ManagedWeather) -> ()) {
        guard let coreDataManager = coreDataManager else { return }
        
        let newWeather = ManagedWeather.create(weatherData: weatherData, forecastData: forecastData, managedContext: coreDataManager.persistentContainer.viewContext)
        managedObjects.append(newWeather)
        coreDataManager.saveContext()
        
        completion(newWeather)
    }
    
//    MARK: Fetching
    
    func fetch(completion: ([ManagedWeather]) -> ()) {
        guard let coreDataManager = coreDataManager else { return }
        
        let fetchRequestWeather = NSFetchRequest<NSManagedObject>(entityName: "ManagedWeather")
        var fetchedList: [NSManagedObject] = []
        var managedWeathers: [ManagedWeather] = []
        
        do {
            fetchedList = try coreDataManager.persistentContainer.viewContext.fetch(fetchRequestWeather)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        managedObjects = fetchedList
        for managedObject in fetchedList {
            managedWeathers.append(managedObject as! ManagedWeather)
        }
        completion(managedWeathers)
    }
    
//    MARK: Deletion
    
    func deleteFromData(at index: Int, completion: () -> ()) {
        guard let coreDataManager = coreDataManager else { return }
        ManagedWeather.delete(weather: managedObjects[index] as! ManagedWeather, managedContext: coreDataManager.persistentContainer.viewContext)
        managedObjects.remove(at: index)
        coreDataManager.saveContext()
        completion()
    }
    
//    MARK: Update
    
    func updateItem(weatherData: [String:Any], forecastData: [[String:Any]], at index: Int, completion: (ManagedWeather) -> ()) {
        guard let coreDataManager = coreDataManager else { return }
        //print(coreDataManager.persistentContainer.persistentStoreDescriptions.first?.url)
        let updatedWeather = ManagedWeather.update(weather: managedObjects[index] as! ManagedWeather, weatherData: weatherData, forecastData: forecastData, managedContext: coreDataManager.persistentContainer.viewContext)
        managedObjects[index] = updatedWeather
        coreDataManager.saveContext()
        completion(updatedWeather)
    }
}
