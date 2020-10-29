//
//  PlaceSearchInteractor.swift
//  CleanWeather
//
//  Created by 18592232 on 13.09.2020.
//  Copyright © 2020 18592232. All rights reserved.
//

import Foundation

//    MARK: Protocols

protocol PlaceSearchBusinessLogic
{
  func fetchSearchResults(prediction: String)
}



//    MARK: Interactor

class PlaceSearchInteractor: PlaceSearchBusinessLogic {
    
    var presenter: PlaceSearchPresentationLogic?
    var networkWorker: PlaceSearchNetworkWorkerProtocol = PlaceSearchNetworkWorker()
    let additionalQueue = OperationQueue()
    
    let searchAPIKey: String
    
    func fetchSearchResults(prediction: String) {
        
        additionalQueue.cancelAllOperations()
        
        let URL = "https://maps.googleapis.com/maps/api/place/autocomplete/json?location&input=\(prediction)&key=\(searchAPIKey)&language=en"
        
        var places: [PlaceSearch.FetchPlaces.Place] = []
        
        if prediction == "" {
            let response = PlaceSearch.FetchPlaces.Response(places: places)
            self.presenter?.presentFetchedPlaces(response: response)
            return
        }
        
        let operation = PlaceSearchNetworkOperation(prediction: URL)
        operation.completionBlock = {
            print("complition block")
            guard let result = operation.result else { print("cancel");return }
            for adress in result {
                let place = PlaceSearch.FetchPlaces.Place(adress: adress)
                places.append(place)
            }
            let response = PlaceSearch.FetchPlaces.Response(places: places)
            OperationQueue.main.addOperation {
                self.presenter?.presentFetchedPlaces(response: response)
            }
        }
        additionalQueue.addOperation(operation)
        
        
        
//        networkWorker.getTownPrediction(prediction: URL) { (results) in
//            for adress in results {
//                let place = PlaceSearch.FetchPlaces.Place(adress: adress)
//                places.append(place)
//            }
//            let response = PlaceSearch.FetchPlaces.Response(places: places)
//            self.presenter?.presentFetchedPlaces(response: response)
//        }
    }
    
    init() {
        guard let keys = PlistAccess().getPlist(withName: "APIKeys") else { fatalError("Cannot read API KEY from plist") }
        searchAPIKey = keys["SearchAPIKey"]!
    }
}
