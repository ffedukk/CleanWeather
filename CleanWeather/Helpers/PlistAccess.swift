//
//  PlistAccess.swift
//  CleanWeather
//
//  Created by 18592232 on 06.09.2020.
//  Copyright © 2020 18592232. All rights reserved.
//

import Foundation

class PlistAccess {
    func getPlist(withName name: String) -> [String:String]? {
        if  let path = Bundle.main.path(forResource: name, ofType: "plist"),
            let xml = FileManager.default.contents(atPath: path) {
            
            return (try? PropertyListSerialization.propertyList(from: xml, options: .mutableContainersAndLeaves, format: nil)) as? [String:String]
        }
        return nil
    }

}


