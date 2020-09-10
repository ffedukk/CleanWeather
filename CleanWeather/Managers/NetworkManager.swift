//
//  NetworkManager.swift
//  CleanWeather
//
//  Created by 18592232 on 06.09.2020.
//  Copyright © 2020 18592232. All rights reserved.
//

import Foundation

class NetworkManager {
    
//    func fetch(url: URL, completion: @escaping (Data)->() ) {
//        let session = URLSession(configuration: .default)
//
//        let task = session.dataTask(with: url) { (data, response, error) in
//            if error != nil {
//                print(error!)
//                return
//            }
//
//            guard let data = data else { return }
//            completion(data)
//        }
//        task.resume()
//    }
    
    let session = URLSession(configuration: .default)
    
    func fetchResult<parser: ParserProtocol>(url: URL, parser: parser, completion: @escaping (Result<parser.Result, Error>)->() ) {
        
        session.dataTask(with: url) { (data, response, error) in
            completion(Result {
                if let err = error { throw err }
                guard let data = data else { throw networkError.NoDataError }
                guard let parsedData = parser.parse(data) else { throw networkError.ParseError }
                return parsedData
            })
        }.resume()
    }
    
    enum networkError: Error {
        case NoDataError
        case ParseError
    }
}

