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
    func displayFetchedWeathers(viewModel: ListWeathers.FetchWeathers.ViewModel)
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
        
        collectionView.setCollectionViewLayout(ListWeathersCollectionViewLayout(), animated: false)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(ListWeathersCell.self, forCellWithReuseIdentifier: ListWeathers.FetchWeathers.ViewModel.DisplayedWeather.identifire)
        collectionView.register(ListWeathersButtonsCell.self, forCellWithReuseIdentifier: ListWeathers.FetchWeathers.ViewModel.Buttons.identifire)
    }
    
    //    MARK: Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor?.fetchWeathersFromCoreData()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        interactor?.updateWeathers()
    }
    
    //    MARK: Display
    
    var displayedItems: [ViewModelProtocol] = []
    
    func displayFetchedWeathers(viewModel: ListWeathers.FetchWeathers.ViewModel) {
        displayedItems = viewModel.displayedItems
        collectionView.reloadData()
    }
    
    //   MARK: Buttons
    
    @objc func addButtonPressed() {
        interactor?.addWeather(place: "moscow")
    }
    
    @objc func editButtonPressed() {
        if displayedItems.count != 1 {
            isEditing ? setEditing(false, animated: true) : setEditing(true, animated: true)
        }
    }
    
    @objc func deleteButtonPressed() {
        if let selectedCells = collectionView.indexPathsForSelectedItems {
            let items = selectedCells.map { $0.item }.sorted(by: >)
            for item in items {
                interactor?.deleteWeather(at: item)
            }
            if displayedItems.count == 1 {
                setEditing(false, animated: false)
            }
        }
    }
}

//MARK: CollectionViewDataSource

extension ListWeathersViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return displayedItems.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let modelItem = displayedItems[indexPath.item]
        
        switch modelItem {
        case is DisplayedWeatherProtocol:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ListWeathers.FetchWeathers.ViewModel.DisplayedWeather.identifire, for: indexPath) as! ListWeathersCell
            cell.setCell(weather: modelItem as! DisplayedWeatherProtocol)
            if indexPath.item != 0 {cell.isInEditingMode = isEditing}
            return cell
        case is DisplayedWeatherButtonsProtocol:
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ListWeathers.FetchWeathers.ViewModel.Buttons.identifire, for: indexPath) as! ListWeathersButtonsCell
        return cell
            
        default:
            fatalError()
        }
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        collectionView.allowsMultipleSelection = editing
        let indexPaths = collectionView.indexPathsForVisibleItems
        for indexPath in indexPaths {
            if (indexPath.item != 0) && (indexPath.item != displayedItems.count - 1) {
                let cell = collectionView.cellForItem(at: indexPath) as! ListWeathersCell
                cell.isInEditingMode = editing
            }
        }
        if let selectedItems = collectionView.indexPathsForSelectedItems {
            for item in selectedItems {
                collectionView.deselectItem(at: item, animated: false)
            }
        }
    }
}

//MARK: CollectionViewDelegate

extension ListWeathersViewController {
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        if indexPath.item != 0 && indexPath.item != displayedItems.count - 1 {
            return true
        }
        else {
            return false
        }
    }
    
    
}

