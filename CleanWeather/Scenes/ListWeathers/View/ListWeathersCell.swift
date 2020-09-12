//
//  ListWeathersCell.swift
//  CleanWeather
//
//  Created by 18592232 on 10.09.2020.
//  Copyright © 2020 18592232. All rights reserved.
//

import UIKit

class ListWeathersCell: ListWeathersBaseCell {
    
//    MARK: Properties
    
    private let placeNameLabel = UILabel()
    private let temperatureLabel = UILabel()
    private let checkmarkLabel = UILabel()
    
    private var back = UIImageView()
    
    override var isInEditingMode: Bool {
        didSet {
            checkmarkLabel.isHidden = !isInEditingMode
            checkmarkLabel.textColor = .gray
        }
    }

    override var isSelected: Bool {
        didSet {
            if isInEditingMode {
                checkmarkLabel.textColor = isSelected ? .white : .gray
            }
        }
    }
    
//    MARK: init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
                
        placeNameLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 33)
        placeNameLabel.textColor = .white
        placeNameLabel.layer.shadowOffset = CGSize(width: 1, height: 1)
        placeNameLabel.layer.shadowRadius = 2
        placeNameLabel.layer.shadowOpacity = 1
        placeNameLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(placeNameLabel)
        
        temperatureLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 40)
        temperatureLabel.textColor = .white
        temperatureLabel.layer.shadowOffset = CGSize(width: 1, height: 1)
        temperatureLabel.layer.shadowRadius = 2
        temperatureLabel.layer.shadowOpacity = 1
        temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(temperatureLabel)
        
        checkmarkLabel.text = "✓"
        checkmarkLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 30)
        checkmarkLabel.textColor = .black
        checkmarkLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(checkmarkLabel)
        
        initConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        back.removeFromSuperview()
    }
    
//    MARK: Constraints
    
    private func initConstraints() {
        NSLayoutConstraint.activate([
            placeNameLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            placeNameLabel.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
            placeNameLabel.trailingAnchor.constraint(equalTo: temperatureLabel.leadingAnchor),
            
            temperatureLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -35),
            temperatureLabel.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
            
            checkmarkLabel.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
            checkmarkLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10)
        ])
    }

    
    
//    MARK: Logic

    override func setCell(weather: ListWeathersViewModelProtocol) {
        let weather = weather as! ListWeathersDisplayedProtocol
        
        placeNameLabel.text = weather.placeName
        temperatureLabel.text = weather.temperature
        isInEditingMode = false
        
        back = UIImageView(frame: bounds)
        let image = UIImage(named: weather.icon)
        back.contentMode = .scaleAspectFill
        back.clipsToBounds = true
        back.image = image
        addSubview(back)
        sendSubviewToBack(back)
        
    }
}
