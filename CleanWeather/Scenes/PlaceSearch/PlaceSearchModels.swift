//
//  PlaceSearchModels.swift
//  CleanWeather
//
//  Created by 18592232 on 13.09.2020.
//  Copyright © 2020 18592232. All rights reserved.
//

import Foundation

enum PlaceSearch
{
    // MARK: Use cases
    
    enum FetchPlaces
    {
        struct Request
        {
        }
        struct Response
        {
            var places: [Place]
        }
        struct Place {
            var adress: String
        }
        struct ViewModel
        {
            struct DisplayedAdress {
                var adress: String
            }
            var displayedAdresses: [DisplayedAdress]
        }
        
    }
    
}

