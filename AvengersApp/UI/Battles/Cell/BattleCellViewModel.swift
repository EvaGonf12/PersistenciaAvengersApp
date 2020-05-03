//
//  BattleCellViewModel.swift
//  AvengersApp
//
//  Created by Eva Gonzalez Ferreira on 24/04/2020.
//  Copyright © 2020 Eva Gonzalez Ferreira. All rights reserved.
//

import Foundation

class BattleCellViewModel {
    let battleID: Int
    let battleName: String
    let battleWinner: WinnerEnum
    let superhero : Superhero?
    let villain : Villain?

    init(battle: Battle) {
        self.battleID = Int(battle.id)
        self.battleName = "Batalla '\(battle.name ?? "None")'"
        self.battleWinner = WinnerEnum(rawValue: battle.winner ?? "Empty") ?? .Empty
        self.superhero = battle.superhero
        self.villain = battle.villain
    }
}
