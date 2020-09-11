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
    
//    MARK: Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        forecastCollectionView.backgroundColor = .clear
        forecastCollectionView.showsHorizontalScrollIndicator = false
        addSubview(forecastCollectionView)
       // forecastCollectionView.dataSource = self
       // forecastCollectionView.delegate = self
       // forecastCollectionView.register(ForecastCell.self, forCellWithReuseIdentifier: "forecastCell")
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
    
    override func setCell(with model: DisplayedViewsForTownProtocol) {
        //self.forecastList = forecastList
    }
}
