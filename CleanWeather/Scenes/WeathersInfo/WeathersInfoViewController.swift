//
//  WeathersInfoViewController.swift
//  CleanWeather
//
//  Created by 18592232 on 10.09.2020.
//  Copyright © 2020 18592232. All rights reserved.
//

import UIKit

//    MARK: Protocols

protocol WeathersInfoDisplayLogic: class
{
    func displayFetchedWeathers(viewModel: WeathersInfo.FetchWeathers.ViewModel)
}

//    MARK: Controller

class WeathersInfoViewController: UICollectionViewController, WeathersInfoDisplayLogic {
    
    var interactor: WeathersInfoBusinessLogic?
    var router: (NSObjectProtocol & WeathersInfoRoutingLogic & WeathersInfoDataPassing)?
    
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
      let interactor = WeathersInfoInteractor()
      let presenter = WeathersInfoPresenter()
      let router = WeathersInfoRouter()
      viewController.interactor = interactor
      viewController.router = router
      interactor.presenter = presenter
      presenter.viewController = viewController
      router.viewController = viewController
      router.dataStore = interactor
    }
    
//    MARK: Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor?.fetchWeathersFromCoreData(request: WeathersInfo.FetchWeathers.Request())
        //interactor?.addWeather(place: "london")
        //interactor?.deleteWeather(at: 1)
        interactor?.updateWeathers()
        
    }
    
//    MARK: Display
    
    var displayedWeathers: [WeathersInfo.FetchWeathers.ViewModel.DisplayedWeather] = []
    
    func displayFetchedWeathers(viewModel: WeathersInfo.FetchWeathers.ViewModel) {
        displayedWeathers = viewModel.displayedWeathers
        print(displayedWeathers.count)
        print(displayedWeathers)
    }
}

