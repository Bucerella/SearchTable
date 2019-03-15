//
//  MyCollectionViewCell.swift
//  SearchingTable
//
//  Created by Buse ERKUŞ on 4.03.2019.
//  Copyright © 2019 Buse ERKUŞ. All rights reserved.
//


import UIKit

class MyCollectionViewCell: UICollectionViewCell {
    
    let nameLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 30))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpView()
        setUpContraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpView() {
        addSubview(nameLabel)
        nameLabel.textAlignment = .center
    }
    
    func setUpContraints() {
        //   Label
        
        //     Constrain to the Cell Margins
        
        let labelLeft = NSLayoutConstraint(item: nameLabel, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1.0, constant: 0)
        let labelTop = NSLayoutConstraint(item: nameLabel, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 0)
        let labelRight = NSLayoutConstraint(item: nameLabel, attribute: .right, relatedBy: .equal, toItem: self , attribute: .right, multiplier: 1.0, constant: 0)
        let labelBottom = NSLayoutConstraint(item: nameLabel, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: 0)
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addConstraints([labelTop, labelLeft, labelRight, labelBottom])
    }
    
    
    
}

