//
//  DataManagerProtocols.swift
//  AvengersApp
//
//  Created by Eva Gonzalez Ferreira on 26/04/2020.
//  Copyright © 2020 Eva Gonzalez Ferreira. All rights reserved.
//

import Foundation

protocol SuperheroDataManager {
    func fetchAllSuperHeroes() -> [Superhero]
    func initSuperheroData()
}

protocol SuperheroDetailDataManager {
    func fetchSuperhero(byID id: Int) -> Superhero?
    func changePowerSuperhero(_ power: Int, withID id: Int, completion: @escaping (Bool) -> ())
}

protocol VillainDataManager {
    func fetchAllVillain() -> [Villain]
    func changePowerVillain(withID id: Int) -> Bool
    func villainDataChenged()
}

protocol BattleDataManager {
    //func fetchAllBattles() -> [Battle]
    //func newBattle() -> Battle?
    func deleteBattle() -> Bool
}

