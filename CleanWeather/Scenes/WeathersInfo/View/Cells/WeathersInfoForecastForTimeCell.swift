//
//  WeathersInfoForecastTimeCell.swift
//  CleanWeather
//
//  Created by 18592232 on 12.09.2020.
//  Copyright © 2020 18592232. All rights reserved.
//

import UIKit

class WeathersInfoForecastForTimeCell: WeathersInfoBaseCell {
    
//    MARK: Properties
    
    private let timeLabel = UILabel()
    private let weatherImageView = UIImageView()
    private let tempLabel = UILabel()
    
//    MARK: Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        timeLabel.textAlignment = .center
        timeLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 16)
        timeLabel.textColor = .white
        timeLabel.layer.shadowOffset = CGSize(width: 1, height: 1)
        timeLabel.layer.shadowRadius = 2
        timeLabel.layer.shadowOpacity = 1
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(timeLabel)
        
        weatherImageView.contentMode = .scaleAspectFit
        weatherImageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(weatherImageView)
        
        tempLabel.textAlignment = .center
        tempLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 16)
        tempLabel.textColor = .white
        tempLabel.layer.shadowOffset = CGSize(width: 1, height: 1)
        tempLabel.layer.shadowRadius = 2
        tempLabel.layer.shadowOpacity = 1
        tempLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(tempLabel)
        
        initConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    MARK: Constraints
    
    private func initConstraints() {
        NSLayoutConstraint.activate([
            timeLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            timeLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            timeLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),

            weatherImageView.topAnchor.constraint(equalTo: timeLabel.bottomAnchor),
            weatherImageView.bottomAnchor.constraint(equalTo: tempLabel.topAnchor),
            weatherImageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            weatherImageView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),

            tempLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            tempLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            tempLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
//    MARK: Logic
    
    override func setCell(with model: DisplayedViewsForTownProtocol) {
        let model = model as! WeathersInfoForecastForTimeProtocol
        timeLabel.text = model.time
        weatherImageView.image = UIImage(named: model.icon)
        tempLabel.text = model.temperature
    }
}
