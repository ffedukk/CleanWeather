//
//  WeatherInfoForecastsCell.swift
//  CleanWeather
//
//  Created by 18592232 on 11.09.2020.
//  Copyright © 2020 18592232. All rights reserved.
//

import UIKit

class WeathersInfoForecastsCell: WeathersInfoBaseCell {
    
//    MARK: Properties

    private var forecastCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
    
    var displayedForecasts: [WeathersInfoForecastForTimeProtocol] = []
    
//    MARK: Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        forecastCollectionView.backgroundColor = .clear
        forecastCollectionView.showsHorizontalScrollIndicator = false
        addSubview(forecastCollectionView)
        forecastCollectionView.dataSource = self
        forecastCollectionView.delegate = self
        forecastCollectionView.register(WeathersInfoForecastForTimeCell.self, forCellWithReuseIdentifier: "weathersInfoForecastForTimeCell")
        forecastCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        constraintsInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
           super.prepareForReuse()
           forecastCollectionView.reloadData()
       }
    
//    MARK: Constraints
    
    private func constraintsInit() {
        NSLayoutConstraint.activate([
            forecastCollectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            forecastCollectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 5),
            forecastCollectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: 5),
            forecastCollectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
//    MARK: Logic
    
    override func setCell(with model: WeathersInfoViewModelProtocol) {
        let model = model as! WeathersInfoDisplayedForecastsProtocol
        displayedForecasts = model.displayedForecast
        forecastCollectionView.reloadData()
    }
}

//MARK: CollectionViewDataSource

extension WeathersInfoForecastsCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return displayedForecasts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let modelItem = displayedForecasts[indexPath.item]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: modelItem.identifire, for: indexPath) as! WeathersInfoBaseCell
        cell.setCell(with: modelItem)
        return cell
    }
    
    
}

//MARK: CollectionViewDelegate

extension WeathersInfoForecastsCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

//MARK: CollectionViewDelegateFlowLayout

extension WeathersInfoForecastsCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: 90)
    }
}
