//
//  BattleTableViewCell.swift
//  AvengersApp
//
//  Created by Eva Gonzalez Ferreira on 24/04/2020.
//  Copyright © 2020 Eva Gonzalez Ferreira. All rights reserved.
//

import UIKit

class BattleTableViewCell: UITableViewCell {

    @IBOutlet weak var battleTitle: UILabel!
    
    @IBOutlet weak var imageVillain: UIImageView!
    @IBOutlet weak var imageSuperhero: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupUI()
    }
    
    var viewModel: BattleCellViewModel? {
        didSet {
            self.setupUI()
        }
    }
    
    func setupUI() {
        guard let viewModel = viewModel else { return }
        self.battleTitle.text = viewModel.battleName
        guard let villain = viewModel.villain,
              let superhero = viewModel.superhero else { return }
        
        imageVillain.image = UIImage(named: villain.image ?? "")
        imageSuperhero.image = UIImage(named: superhero.image ?? "")
        
        self.imageVillain.layer.cornerRadius = 8
        self.imageSuperhero.layer.cornerRadius = 8

        switch self.viewModel?.battleWinner {
            case .Superhero:
                self.imageSuperhero.layer.borderWidth = 6
                self.imageSuperhero.layer.borderColor = UIColor(named: Colors.Win.rawValue)?.cgColor
            case .Villain:
                self.imageVillain.layer.borderWidth = 6
                self.imageVillain.layer.borderColor = UIColor(named: Colors.Win.rawValue)?.cgColor
            case .Empty:
                break
            case .none:
                break
        }
    }
    
}
