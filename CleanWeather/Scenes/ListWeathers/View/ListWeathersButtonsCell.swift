//
//  ListWeathersButtonsCell.swift
//  CleanWeather
//
//  Created by 18592232 on 10.09.2020.
//  Copyright © 2020 18592232. All rights reserved.
//

import UIKit

class ListWeathersButtonsCell: ListWeathersBaseCell {
    
    private let addButton = UIButton(type: .contactAdd)
    private let editButton = UIButton()
    //private let deleteButton = UIButton(type: .infoLight)
    private let deleteButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
        initConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        addButton.tintColor = .white
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(addButton)
        addButton.addTarget(nil, action: Selector(("addButtonPressed")), for: .touchUpInside)
        
        editButton.tintColor = .white
        editButton.setTitle("Edit", for: .normal)
        editButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(editButton)
        editButton.addTarget(nil, action: Selector(("editButtonPressed")), for: .touchUpInside)
        
        deleteButton.setImage(UIImage(systemName: "trash"), for: .normal)
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(deleteButton)
        deleteButton.addTarget(nil, action: Selector(("deleteButtonPressed")), for: .touchUpInside)
    }
    
    private func initConstraints() {
        NSLayoutConstraint.activate([
            addButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            addButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),

            editButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            editButton.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),

            deleteButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            deleteButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 30),
        ])
    }
}
