//
//  PredictionCell.swift
//  CleanWeather
//
//  Created by 18592232 on 13.09.2020.
//  Copyright © 2020 18592232. All rights reserved.
//

import UIKit

class PredictionCell: UITableViewCell {
    
//    MARK: Properties
    
    private let townNameLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clear
        
        townNameLabel.textColor = .white
        townNameLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(townNameLabel)
        
        initConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    MARK: Constraints
    
    private func initConstraints() {
        NSLayoutConstraint.activate([
            townNameLabel.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
            townNameLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 30),
            townNameLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20)
        ])
    }
    
//    MARK: Logic
    
    func setCell(town: PlaceSearch.FetchPlaces.ViewModel.DisplayedAdress) {
        townNameLabel.text = town.adress
    }
}
