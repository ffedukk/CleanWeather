//
//  TownCell.swift
//  CleanWeather
//
//  Created by 18592232 on 11.09.2020.
//  Copyright © 2020 18592232. All rights reserved.
//

import UIKit

class WeatherInfoCell: UICollectionViewCell{
    
//    MARK: Properties
    
    private var townViews: [WeathersInfoViewModelProtocol]?
    private var townCollectionView = UICollectionView(frame: .zero, collectionViewLayout: WeatherInfoCellLayout())
    private var back = UIImageView()
    
//    MARK: Initialization
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        townCollectionView.showsVerticalScrollIndicator = false
        addSubview(townCollectionView)
        townCollectionView.dataSource = self
//        townCollectionView.delegate = self
        townCollectionView.register(WeathersInfoHeaderCell.self, forCellWithReuseIdentifier: "weathersInfoHeaderCell")
        townCollectionView.register(WeathersInfoForecastsCell.self, forCellWithReuseIdentifier: "weathersInfoForecastsCell")
        townCollectionView.register(WeathersInfoAdditionalInfoCell.self, forCellWithReuseIdentifier: "weathersInfoAdditionalInfoCell")
        townCollectionView.translatesAutoresizingMaskIntoConstraints = false
        townCollectionView.backgroundColor = .clear
        
        constraintsInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        townViews = nil
        townCollectionView.reloadData()
    }
    
    //    MARK: Constraints
    
    private func constraintsInit() {
        NSLayoutConstraint.activate([
            townCollectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            townCollectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            townCollectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            townCollectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -50)
        ])
    }
    
//    MARK: Logic
    
    func setCell(with weather: WeathersInfoViewModelProtocol) {
        let weather = weather as! WeathersInfoDisplayedTownProtocol
        townViews = weather.displayedViewsForTown
        
        back = UIImageView(frame: bounds)
        let image = UIImage(named: weather.icon)
        back.contentMode = .scaleAspectFill
        back.clipsToBounds = true
        back.image = image
        self.backgroundView = back
    }
}

//MARK: CollectionViewDataSource

extension WeatherInfoCell: UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return townViews!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let modelItem = townViews![indexPath.item]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: modelItem.identifire, for: indexPath) as! WeathersInfoBaseCell
        cell.setCell(with: modelItem)
        return cell
    }
}
