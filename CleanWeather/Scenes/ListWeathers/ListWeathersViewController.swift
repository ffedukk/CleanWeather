//
//  ViewController.swift
//  CleanWeather
//
//  Created by 18592232 on 06.09.2020.
//  Copyright © 2020 18592232. All rights reserved.
//

import UIKit

//    MARK: Protocols

protocol ListWeathersDisplayLogic: class
{
    func displayFetchedWeathers(viewModel: ListWeathers.FetchWeathers.ViewModel)//viewModel: ListOrders.FetchOrders.ViewModel)
}

//    MARK: Controller

class ListWeathersViewController: UICollectionViewController, ListWeathersDisplayLogic {
    
    var interactor: ListWeathersBusinessLogic?
    
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
      let interactor = ListWeathersInteractor()
      let presenter = ListWeathersPresenter()
      //let router = ListOrdersRouter()
      viewController.interactor = interactor
      //viewController.router = router
      interactor.presenter = presenter
      presenter.viewController = viewController
      //router.viewController = viewController
      //router.dataStore = interactor
    }
    
//    MARK: Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor?.fetchWeathersFromCoreData()
        //interactor?.addWeather(place: "london")
        //interactor?.deleteWeather(at: 1)
        interactor?.updateWeathers()
        
    }
    
//    MARK: Display
    
    var displayedWeathers: [ListWeathers.FetchWeathers.ViewModel.DisplayedWeather] = []
    
    func displayFetchedWeathers(viewModel: ListWeathers.FetchWeathers.ViewModel) {
        displayedWeathers = viewModel.displayedWeathers
        print(displayedWeathers.count)
    }

}

