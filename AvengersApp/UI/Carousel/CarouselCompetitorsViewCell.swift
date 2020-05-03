//
//  CarouselCompetitorsCollectionViewCell.swift
//  AvengersApp
//
//  Created by Eva Gonzalez Ferreira on 02/05/2020.
//  Copyright © 2020 Eva Gonzalez Ferreira. All rights reserved.
//

import UIKit

class CarouselCompetitorsViewCell: UICollectionViewCell {
        
    lazy var competitorImage: UIImageView = {
        let iv = UIImageView(frame: CGRect(x: 0, y: 0, width: 80, height: 50))
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.layer.cornerRadius = 8
        return iv
    }()
    
    lazy var competitorName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var competitorStackView: UIStackView = {
        let competitorStackView = UIStackView(arrangedSubviews: [competitorImage, competitorName])
        competitorStackView.translatesAutoresizingMaskIntoConstraints = false
        competitorStackView.axis = .vertical
        return competitorStackView
    }()
    
    var name: String? {
        didSet {
            guard let name = name else { return }
            competitorName.text = name
        }
    }
    
    var image: String? {
        didSet {
            guard let imageName = image else { return }
            competitorImage.image = UIImage(named: imageName)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(competitorStackView)
        NSLayoutConstraint.activate([
            competitorStackView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 5),
            competitorStackView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -5),
            competitorStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            competitorStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5)
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
