//
//  JSONPredictionParser.swift
//  CleanWeather
//
//  Created by 18592232 on 13.09.2020.
//  Copyright © 2020 18592232. All rights reserved.
//

import Foundation

class JSONPredictionParser: ParserProtocol {

    func parse(_ data: Data) -> [String]? {
        
        var result = [String]()
        
        do {
            if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] {
                guard let jsonList = json["predictions"] as? [[String:Any]], !jsonList.isEmpty else { return nil }
                for object in jsonList {
                    if let description = object["description"] as? String {
                        result.append(description)
                    }
                }
            }
        } catch {
            print("JSON error: \(error.localizedDescription)")
            return nil
        }
        return result
    }
}
