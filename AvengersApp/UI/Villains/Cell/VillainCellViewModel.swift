//
//  VillainCellViewModel.swift
//  AvengersApp
//
//  Created by Eva Gonzalez Ferreira on 24/04/2020.
//  Copyright © 2020 Eva Gonzalez Ferreira. All rights reserved.
//

import Foundation

class VillainCellViewModel {
    let villainID: Int
    let villainImage: String
    let villainName: String
    let villainPower: String

    init(villain: Villain) {
        self.villainID = Int(villain.id)
        self.villainImage = villain.image ?? "img_default"
        self.villainName = villain.name ?? "None"
        self.villainPower = "ic_stars_\(villain.power)"
    }
}
