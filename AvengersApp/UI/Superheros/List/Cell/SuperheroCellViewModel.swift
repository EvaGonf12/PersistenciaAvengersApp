//
//  SuperheroCellViewModel.swift
//  AvengersApp
//
//  Created by Eva Gonzalez Ferreira on 24/04/2020.
//  Copyright © 2020 Eva Gonzalez Ferreira. All rights reserved.
//

import Foundation

class SuperheroCellViewModel {
    let superheroID: Int
    let superheroImage: String
    let superheroName: String
    let superheroPower: String

    init(superhero: Superhero) {
        self.superheroID = Int(superhero.id)
        self.superheroImage = superhero.image ?? "img_default"
        self.superheroName = superhero.name ?? "None"
        self.superheroPower = "ic_stars_\(superhero.power)"
    }
}
