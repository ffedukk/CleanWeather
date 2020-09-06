//
//  ViewController.swift
//  CleanWeather
//
//  Created by 18592232 on 06.09.2020.
//  Copyright © 2020 18592232. All rights reserved.
//

import UIKit

protocol ListWeathersDisplayLogic: class
{
  func displayFetchedWeathers()//viewModel: ListOrders.FetchOrders.ViewModel)
}

class ListWeathersViewController: UICollectionViewController, ListWeathersDisplayLogic {
    
    var interactor: ListWeathersBusinessLogic?
    
    override init(collectionViewLayout layout: UICollectionViewLayout) {
        super.init(collectionViewLayout: layout)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func displayFetchedWeathers() {
        
    }

}

