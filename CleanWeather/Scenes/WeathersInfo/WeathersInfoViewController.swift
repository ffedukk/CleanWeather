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
    var router: (WeathersInfoRoutingLogic & WeathersInfoDataPassing)?
    
    let pageControl = UIPageControl()
    
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
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView.isPagingEnabled = true
        collectionView.setCollectionViewLayout(layout, animated: false)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.contentInsetAdjustmentBehavior = .scrollableAxes
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(WeatherInfoCell.self, forCellWithReuseIdentifier: "weathersInfoCell")
        
        
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.isUserInteractionEnabled = false
        pageControl.numberOfPages = 5
        view.addSubview(pageControl)
    }
    
    private func constraintsInit() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            pageControl.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            pageControl.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            pageControl.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            pageControl.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    //    MARK: Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        interactor?.fetchWeathers()
        constraintsInit()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

    }
    
    //    MARK: Display
    
    var displayedWeathers: [WeathersInfoViewModelProtocol] = []
    
    func displayFetchedWeathers(viewModel: WeathersInfo.FetchWeathers.ViewModel) {
        displayedWeathers = viewModel.displayedWeathers
        collectionView.reloadData()
    }
}

//MARK: CollectionViewDataSource

extension WeathersInfoViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return displayedWeathers.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let modelItem = displayedWeathers[indexPath.item]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: modelItem.identifire, for: indexPath) as! WeatherInfoCell
        cell.setCell(with: modelItem)
        return cell
    }
}

//MARK: CollectionViewDelegate

extension WeathersInfoViewController {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

//    MARK: CollectionViewDelegateFlowLayout

extension WeathersInfoViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
}

