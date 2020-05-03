//
//  CompetitorCellViewModel.swift
//  AvengersApp
//
//  Created by Eva Gonzalez Ferreira on 02/05/2020.
//  Copyright © 2020 Eva Gonzalez Ferreira. All rights reserved.
//


import Foundation

class ListCompetitorCellViewModel {
    var id : Int
    var image : String
    var name : String
    
    init(competitor: Superhero) {
        self.id = Int(competitor.id)
        self.image = competitor.image ?? "img_default"
        self.name = competitor.name ?? "None"
    }
    
    init(competitor: Villain) {
        self.id = Int(competitor.id)
        self.image = competitor.image ?? "img_default"
        self.name = competitor.name ?? "None"
    }
}
