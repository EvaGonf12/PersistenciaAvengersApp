//
//  SuperheroTableViewCell.swift
//  AvengersApp
//
//  Created by Eva Gonzalez Ferreira on 26/04/2020.
//  Copyright © 2020 Eva Gonzalez Ferreira. All rights reserved.
//

import UIKit

class SuperheroTableViewCell: UITableViewCell {
    
    @IBOutlet weak var superheroImage: UIImageView!
    @IBOutlet weak var superheroName: UILabel!
    @IBOutlet weak var superheroPower: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    var viewModel: SuperheroCellViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            superheroName.text = viewModel.superheroName
            superheroImage.image = UIImage(named: viewModel.superheroImage)
            superheroPower.image = UIImage(named: viewModel.superheroPower)
        }
    }
}
