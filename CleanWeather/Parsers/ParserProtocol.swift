//
//  ParserProtocol.swift
//  CleanWeather
//
//  Created by 18592232 on 06.09.2020.
//  Copyright © 2020 18592232. All rights reserved.
//

import Foundation

protocol ParserProtocol {
    associatedtype Result
    func parse(_ data: Data) -> Result?
}
