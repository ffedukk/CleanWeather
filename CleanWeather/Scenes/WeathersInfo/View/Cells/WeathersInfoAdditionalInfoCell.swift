//
//  WeathersInfoAdditionalInfoCell.swift
//  CleanWeather
//
//  Created by 18592232 on 11.09.2020.
//  Copyright © 2020 18592232. All rights reserved.
//

import UIKit

class WeathersInfoAdditionalInfoCell: WeathersInfoBaseCell {
    
//    MARK: Properties
    
    private let descriptionLabel = UILabel()
    private let mainInfoLabel = UILabel()
    
//    MARK: Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        descriptionLabel.font = UIFont(name: "AppleSDGothicNeo-UltraLight", size: 17)
        descriptionLabel.textColor = .white
        descriptionLabel.layer.shadowOffset = CGSize(width: 1, height: 1)
        descriptionLabel.layer.shadowRadius = 2
        descriptionLabel.layer.shadowOpacity = 1
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(descriptionLabel)
        
        mainInfoLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 30)
        mainInfoLabel.textColor = .white
        mainInfoLabel.layer.shadowOffset = CGSize(width: 1, height: 1)
        mainInfoLabel.layer.shadowRadius = 2
        mainInfoLabel.layer.shadowOpacity = 1
        mainInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(mainInfoLabel)
    
        initConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    MARK: Constraints
    
    private func initConstraints() {
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 5),
            descriptionLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10),
            
            mainInfoLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor),
            mainInfoLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10)
        ])
    }
    
//    MARK: Logic
    
    override func setCell(with model: WeathersInfoViewModelProtocol) {
        let additionalInfo = model as! WeathersInfoDisplayedAdditionalInfoProtocol
        descriptionLabel.text = additionalInfo.title
        mainInfoLabel.text = additionalInfo.data
    }
}
