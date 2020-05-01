//
//  VillainDetailViewModel.swift
//  AvengersApp
//
//  Created by Eva Gonzalez Ferreira on 25/04/2020.
//  Copyright © 2020 Eva Gonzalez Ferreira. All rights reserved.
//

import Foundation

class VillainDetailViewModel {
    let villainImage: String
    let villainName: String
    let villainPower: String
    let villainDescription: String
    //let villainBattles: [Battle]

    init(villain: Villain) {
        self.villainImage = villain.image ?? ""
        self.villainName = villain.name ?? ""
        self.villainPower = "ic_stars_\(villain.power)"
        self.villainDescription = villain.description
        //self.villainBattles = []
    }
}
