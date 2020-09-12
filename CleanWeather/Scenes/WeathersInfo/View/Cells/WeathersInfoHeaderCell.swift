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
    
    private let placeNameLabel = UILabel()
    private let weatherDescriptionLabel = UILabel()
    private let temperatureLabel = UILabel()
    private let temperatureMaxLabel = UILabel()
    private let temperatureMinLabel = UILabel()
    
//    MARK: Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        placeNameLabel.textAlignment = .center
        placeNameLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 35)
        placeNameLabel.textColor = .white
        placeNameLabel.layer.shadowOffset = CGSize(width: 1, height: 1)
        placeNameLabel.layer.shadowRadius = 2
        placeNameLabel.layer.shadowOpacity = 1
        placeNameLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(placeNameLabel)
        
        weatherDescriptionLabel.textAlignment = .center
        weatherDescriptionLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 15)
        weatherDescriptionLabel.textColor = .white
        weatherDescriptionLabel.layer.shadowOffset = CGSize(width: 1, height: 1)
        weatherDescriptionLabel.layer.shadowRadius = 2
        weatherDescriptionLabel.layer.shadowOpacity = 1
        weatherDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(weatherDescriptionLabel)
        
        temperatureLabel.textAlignment = .center
        temperatureLabel.font = UIFont(name: "AppleSDGothicNeo-Thin", size: 100)
        temperatureLabel.textColor = .white
        temperatureLabel.layer.shadowOffset = CGSize(width: 1, height: 1)
        temperatureLabel.layer.shadowRadius = 2
        temperatureLabel.layer.shadowOpacity = 1
        temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(temperatureLabel)
        
        temperatureMaxLabel.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 16)
        temperatureMaxLabel.textColor = .white
        temperatureMaxLabel.layer.shadowOffset = CGSize(width: 1, height: 1)
        temperatureMaxLabel.layer.shadowRadius = 2
        temperatureMaxLabel.layer.shadowOpacity = 1
        temperatureMaxLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(temperatureMinLabel)
        
        temperatureMinLabel.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 16)
        temperatureMinLabel.textColor = .white
        temperatureMinLabel.layer.shadowOffset = CGSize(width: 1, height: 1)
        temperatureMinLabel.layer.shadowRadius = 2
        temperatureMinLabel.layer.shadowOpacity = 1
        temperatureMinLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(temperatureMaxLabel)
        
        initConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    MARK: Constraints
    
    private func initConstraints() {
        NSLayoutConstraint.activate([
            placeNameLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 75),
            placeNameLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            placeNameLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            
            weatherDescriptionLabel.topAnchor.constraint(equalTo: placeNameLabel.bottomAnchor, constant: -5),
            weatherDescriptionLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            weatherDescriptionLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),

            temperatureLabel.topAnchor.constraint(equalTo: weatherDescriptionLabel.bottomAnchor),
            temperatureLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            temperatureLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            
            temperatureMinLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -5),
            temperatureMinLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -5),
            
            temperatureMaxLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -5),
            temperatureMaxLabel.trailingAnchor.constraint(equalTo: temperatureMinLabel.leadingAnchor, constant: -5)
        ])
    }
    
//    MARK: Logic
    
    override func setCell(with model: WeathersInfoViewModelProtocol) {
        let model = model as! WeathersInfoDisplayedHeaderProtocol
        placeNameLabel.text = model.placeName
        weatherDescriptionLabel.text = model.weatherDescription
        temperatureLabel.text = model.temperature
        temperatureMinLabel.text = model.temperatureMin
        temperatureMaxLabel.text = model.temperatureMax
    }
}
