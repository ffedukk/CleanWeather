//
//  PlaceSearchPresenter.swift
//  CleanWeather
//
//  Created by 18592232 on 13.09.2020.
//  Copyright © 2020 18592232. All rights reserved.
//

import Foundation

//    MARK: Protocols

protocol PlaceSearchPresentationLogic
{
    func presentFetchedPlaces(response: PlaceSearch.FetchPlaces.Response)
}

//    MARK: Presenter

class PlaceSearchPresenter: PlaceSearchPresentationLogic {
    
    weak var viewController: PlaceSearchDisplayLogic?

    func presentFetchedPlaces(response: PlaceSearch.FetchPlaces.Response) {
        
        var displayedAdresses: [PlaceSearch.FetchPlaces.ViewModel.DisplayedAdress] = []
        
        for adress in response.places {
            let displayedAdress = PlaceSearch.FetchPlaces.ViewModel.DisplayedAdress(adress: adress.adress)
            displayedAdresses.append(displayedAdress)
        }
        let viewModel = PlaceSearch.FetchPlaces.ViewModel(displayedAdresses: displayedAdresses)
        viewController?.displayFetcheSearchResults(viewModel: viewModel)
    }
}
