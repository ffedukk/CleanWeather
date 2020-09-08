//
//  ManagedForecast.swift
//  CleanWeather
//
//  Created by 18592232 on 06.09.2020.
//  Copyright © 2020 18592232. All rights reserved.
//

import Foundation
import CoreData

@objc(ManagedForecast)
public class ManagedForecast: NSManagedObject {
    
    public class func create(dict: [String: Any], weather: ManagedWeather, managedContext: NSManagedObjectContext) {
        let forecast = ManagedForecast(context: managedContext)
        forecast.time = dict["date"] as? String
        forecast.temperature = dict["temp"] as! Double
        forecast.icon =  dict["weather"] as? String
        
        forecast.managedWeather = weather
    }
    
    public class func delete(forecast: ManagedForecast, managedContext: NSManagedObjectContext) {
        managedContext.delete(forecast)
    }

}

extension ManagedForecast {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ManagedForecast> {
        return NSFetchRequest<ManagedForecast>(entityName: "ManagedForecast")
    }

    @NSManaged public var time: String?
    @NSManaged public var temperature: Double
    @NSManaged public var icon: String?
    @NSManaged public var managedWeather: ManagedWeather?
    
    
}
