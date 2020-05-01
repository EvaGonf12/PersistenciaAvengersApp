//
//  CarouselCollectionViewCell.swift
//  AvengersApp
//
//  Created by Eva Gonzalez Ferreira on 27/04/2020.
//  Copyright © 2020 Eva Gonzalez Ferreira. All rights reserved.
//

import UIKit

class CarouselCollectionViewCell: UICollectionViewCell {
        
    fileprivate let battleButton: UIButton = {
       let iv = UIButton()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.layer.cornerRadius = 15
        return iv
    }()
    
    var title: String? {
        didSet {
            guard let title = title else { return }
            battleButton.setTitle(title, for: .normal)
        }
    }
    
    var color: Colors? {
        didSet {
            guard let color = color else { return }
            battleButton.backgroundColor = UIColor(named: color.rawValue)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(battleButton)

        battleButton.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        battleButton.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        battleButton.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        battleButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
