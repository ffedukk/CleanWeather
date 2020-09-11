//
//  WeathersInfoHeaderCell.swift
//  CleanWeather
//
//  Created by 18592232 on 11.09.2020.
//  Copyright © 2020 18592232. All rights reserved.
//

import UIKit

class WeathersInfoHeaderCell: WeathersInfoBaseCell {
    
//    MARK: Properties
    
    private let townNameLabel = UILabel()
    private let weatherDescriptionLabel = UILabel()
    private let tempLabel = UILabel()
    private let tempMaxLabel = UILabel()
    private let tempMinLabel = UILabel()
    
//    MARK: Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        townNameLabel.textAlignment = .center
        townNameLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 35)
        townNameLabel.textColor = .white
        townNameLabel.layer.shadowOffset = CGSize(width: 1, height: 1)
        townNameLabel.layer.shadowRadius = 2
        townNameLabel.layer.shadowOpacity = 1
        townNameLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(townNameLabel)
        
        weatherDescriptionLabel.textAlignment = .center
        weatherDescriptionLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 15)
        weatherDescriptionLabel.textColor = .white
        weatherDescriptionLabel.layer.shadowOffset = CGSize(width: 1, height: 1)
        weatherDescriptionLabel.layer.shadowRadius = 2
        weatherDescriptionLabel.layer.shadowOpacity = 1
        weatherDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(weatherDescriptionLabel)
        
        tempLabel.textAlignment = .center
        tempLabel.font = UIFont(name: "AppleSDGothicNeo-Thin", size: 100)
        tempLabel.textColor = .white
        tempLabel.layer.shadowOffset = CGSize(width: 1, height: 1)
        tempLabel.layer.shadowRadius = 2
        tempLabel.layer.shadowOpacity = 1
        tempLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(tempLabel)
        
        tempMaxLabel.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 16)
        tempMaxLabel.textColor = .white
        tempMaxLabel.layer.shadowOffset = CGSize(width: 1, height: 1)
        tempMaxLabel.layer.shadowRadius = 2
        tempMaxLabel.layer.shadowOpacity = 1
        tempMaxLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(tempMinLabel)
        
        tempMinLabel.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 16)
        tempMinLabel.textColor = .white
        tempMinLabel.layer.shadowOffset = CGSize(width: 1, height: 1)
        tempMinLabel.layer.shadowRadius = 2
        tempMinLabel.layer.shadowOpacity = 1
        tempMinLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(tempMaxLabel)
        
        initConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    MARK: Constraints
    
    private func initConstraints() {
        NSLayoutConstraint.activate([
            townNameLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 75),
            townNameLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            townNameLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            
            weatherDescriptionLabel.topAnchor.constraint(equalTo: townNameLabel.bottomAnchor, constant: -5),
            weatherDescriptionLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            weatherDescriptionLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),

            tempLabel.topAnchor.constraint(equalTo: weatherDescriptionLabel.bottomAnchor),
            tempLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            tempLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            
            tempMinLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -5),
            tempMinLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -5),
            
            tempMaxLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -5),
            tempMaxLabel.trailingAnchor.constraint(equalTo: tempMinLabel.leadingAnchor, constant: -5)
        ])
    }
    
//    MARK: Logic
    
    override func setCell(with model: DisplayedViewsForTownProtocol) {
        let header = model as! WeathersInfoDisplayedHeaderProtocol
        townNameLabel.text = header.placeName
        weatherDescriptionLabel.text = header.weatherDescription
        tempLabel.text = header.temperature
        tempMinLabel.text = header.temperatureMin
        tempMaxLabel.text = header.temperatureMax
    }
}
