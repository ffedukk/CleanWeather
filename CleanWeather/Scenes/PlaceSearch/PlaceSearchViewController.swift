//
//  PlaceSearchViewController.swift
//  CleanWeather
//
//  Created by 18592232 on 13.09.2020.
//  Copyright © 2020 18592232. All rights reserved.
//


import UIKit

//    MARK: Protocols

protocol PlaceSearchDisplayLogic: class
{
    func displayFetchedWeathers(viewModel: PlaceSearch.FetchWeathers.ViewModel)
}

//    MARK: Controller

class PlaceSearchViewController: UICollectionViewController, PlaceSearchDisplayLogic {
    
    
    
    var interactor: PlaceSearchBusinessLogic?
    var router: PlaceSearchDataPassing?
    
    //    MARK: Init
    
    override init(collectionViewLayout layout: UICollectionViewLayout) {
        super.init(collectionViewLayout: layout)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //    MARK: Setup
    
    private func setup() {
        let viewController = self
        let interactor = PlaceSearchInteractor()
        let presenter = PlaceSearchPresenter()
        let router = PlaceSearchRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        //router.dataStore = interactor
    }
    
//    MARK: Display
    
    func displayFetchedWeathers(viewModel: PlaceSearch.FetchWeathers.ViewModel) {
        
    }
}

