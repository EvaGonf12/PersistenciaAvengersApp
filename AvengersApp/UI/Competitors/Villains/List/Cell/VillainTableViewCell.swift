//
//  VillainTableViewCell.swift
//  AvengersApp
//
//  Created by Eva Gonzalez Ferreira on 24/04/2020.
//  Copyright © 2020 Eva Gonzalez Ferreira. All rights reserved.
//

import UIKit

class VillainTableViewCell: UITableViewCell {
    
    @IBOutlet weak var villainImage: UIImageView!
    @IBOutlet weak var villainName: UILabel!
    @IBOutlet weak var villainPower: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupUI()
    }
    
    var viewModel: VillainCellViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            villainName.text = viewModel.villainName
            villainImage.image = UIImage(named: viewModel.villainImage)
            villainPower.image = UIImage(named: viewModel.villainPower)
        }
    }
    
    func setupUI() {
        self.villainPower.image = self.villainPower.image?.withRenderingMode(.alwaysTemplate)
        self.villainPower.tintColor = UIColor(named: Colors.RedVillain.rawValue)
        self.villainImage.layer.cornerRadius = 8
        self.villainImage.layer.borderWidth = 4
        self.villainImage.layer.borderColor = UIColor(named: Colors.RedVillain.rawValue)?.cgColor
    }
}
