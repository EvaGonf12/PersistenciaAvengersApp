//
//  CreateBattleViewModel.swift
//  AvengersApp
//
//  Created by Eva Gonzalez Ferreira on 02/05/2020.
//  Copyright © 2020 Eva Gonzalez Ferreira. All rights reserved.
//

import Foundation

protocol BattlesViewModelDelegate : class {
    func createBattle(name: String, villain: Villain, superhero: Superhero, winner: WinnerEnum)
}

protocol CreateBattleViewDelegate: class {
    func competitorSelected(type: CompetitorType, _ id: Int)
    func reloadData()
}

class CreateBattleViewModel {
    weak var battlesViewDelegate: BattlesViewModelDelegate?
    weak var createBattleViewDelegate: CreateBattleViewDelegate?
    
    var superherosViewModels: [Superhero] = []
    var villainsViewModels: [Villain] = []
    
    var name: String?
    var villainSelected: Villain?
    var superheroSelected: Superhero?
    
    init(superherosViewModels: [Superhero],
         villainsViewModels: [Villain]) {
        self.superherosViewModels = superherosViewModels
        self.villainsViewModels = villainsViewModels
    }
    
    func isVillainSelected() -> Bool {
        return villainSelected != nil
    }
    
    func isSuperheroSelected() -> Bool {
        return superheroSelected != nil
    }
    
    func competitorSelected(type: CompetitorType, _ id: Int) {
        switch type {
            case .Superhero:
                self.superheroSelected = self.superherosViewModels.filter({ (superhero) -> Bool in
                    return superhero.id == id
                    }).first
                
            case .Villain:
                self.villainSelected = self.villainsViewModels.filter({ (villain) -> Bool in
                    return villain.id == id
                    }).first
        }
        self.createBattleViewDelegate?.reloadData()
    }
    
    func createBattle() {
        guard let name = self.name,
              let superhero = self.superheroSelected,
              let villain = self.villainSelected else { return }
        
        var winner = WinnerEnum.Empty
        
        if villain.power == superhero.power {
            winner = Int.random(in: 0 ..< 2) == 0 ? WinnerEnum.Superhero : WinnerEnum.Villain
        } else {
            winner = superhero.power > villain.power ? WinnerEnum.Superhero : WinnerEnum.Villain
        }
        
        self.battlesViewDelegate?.createBattle(name: name, villain: villain, superhero: superhero, winner: winner)
    }
}
