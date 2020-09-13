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
    func displayFetcheSearchResults(viewModel: PlaceSearch.FetchPlaces.ViewModel)
}

//    MARK: Controller

class PlaceSearchViewController: UIViewController, PlaceSearchDisplayLogic {
    
    var interactor: PlaceSearchBusinessLogic?
    var router: (PlaceSearchDataPassing & PlaceSearchRoutingLogic)?
    
    private let searchView = UISearchBar()
    private let resultTableView = UITableView()
    
    //    MARK: Init
    
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
        
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)
        
        let cancelButtonAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        UIBarButtonItem.appearance().setTitleTextAttributes(cancelButtonAttributes , for: .normal)
        searchView.searchTextField.textColor = .white
        searchView.searchTextField.backgroundColor = .lightGray
        searchView.placeholder = "Search"
        searchView.searchBarStyle = .minimal
        searchView.becomeFirstResponder()
        searchView.delegate = self
        searchView.showsCancelButton = true
        searchView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(searchView)
        
        resultTableView.backgroundColor = .clear
        resultTableView.separatorStyle = .none
        resultTableView.dataSource = self
        resultTableView.delegate = self
        resultTableView.register(PredictionCell.self, forCellReuseIdentifier: "predictionCell")
        resultTableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(resultTableView)
        
        initConstraints()
        
    }
    
    private func initConstraints() {
        NSLayoutConstraint.activate([
            searchView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            searchView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            searchView.heightAnchor.constraint(equalToConstant: 60),
            
            resultTableView.topAnchor.constraint(equalTo: searchView.bottomAnchor),
            resultTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            resultTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            resultTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
//MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        searchView.searchTextField.isSelected = true
    }
    
//    MARK: Display
    
    private var displayedSearchResults = [PlaceSearch.FetchPlaces.ViewModel.DisplayedAdress]()
    
    func displayFetcheSearchResults(viewModel: PlaceSearch.FetchPlaces.ViewModel) {
        displayedSearchResults = viewModel.displayedAdresses
        resultTableView.reloadData()
    }
    
    deinit {
        print("deinit PlaceSearch")
    }
}

//MARK: SearchBarDelegate

extension PlaceSearchViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        navigationController?.popViewController(animated: true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        interactor?.fetchSearchResults(prediction: searchText)
    }
}

//MARK: TableViewDataSource

extension PlaceSearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayedSearchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "predictionCell", for: indexPath) as! PredictionCell
        cell.setCell(town: displayedSearchResults[indexPath.row])
        return cell
    }
}

//MARK: UITableViewDelegate

extension PlaceSearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let passedData = self.displayedSearchResults[indexPath.row].adress.replacingOccurrences(of: " ", with: "")
        print(passedData)
        self.router?.routeToListWeathers(with: passedData)
        
    }
}
