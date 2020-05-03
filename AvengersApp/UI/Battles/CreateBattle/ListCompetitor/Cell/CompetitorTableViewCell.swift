//
//  CompetitorTableViewCell.swift
//  AvengersApp
//
//  Created by Eva Gonzalez Ferreira on 02/05/2020.
//  Copyright © 2020 Eva Gonzalez Ferreira. All rights reserved.
//

import UIKit

class CompetitorTableViewCell: UITableViewCell {

    @IBOutlet weak var competitorImage: UIImageView!
    @IBOutlet weak var competitorName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupUI()
    }
    
    var viewModel: ListCompetitorCellViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            competitorImage.image = UIImage(named: viewModel.image)
            competitorName.text = viewModel.name
        }
    }
    
    func setupUI() {
        self.competitorImage.layer.cornerRadius = 8
        self.competitorImage.layer.borderWidth = 4
    }
    
}
