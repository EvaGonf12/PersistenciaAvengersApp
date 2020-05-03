//
//  DataManagerProtocols.swift
//  AvengersApp
//
//  Created by Eva Gonzalez Ferreira on 26/04/2020.
//  Copyright © 2020 Eva Gonzalez Ferreira. All rights reserved.
//

import Foundation

protocol SuperherosDataManager {
    func fetchAllSuperHeroes() -> [Superhero]
    func initSuperheroData()
}

protocol SuperheroDetailDataManager {
    func fetchSuperhero(byID id: Int) -> (Superhero, [Battle])?
    func changePowerSuperhero(_ power: Int, withID id: Int, completion: @escaping (Bool) -> ())
}

protocol VillainDataManager {
    func fetchAllVillains() -> [Villain]
    func initVillainData()
}

protocol VillainDetailDataManager {
    func fetchVillain(byID id: Int) -> (Villain, [Battle])?
    func changePowerVillain(_ power: Int, withID id: Int, completion: @escaping (Bool) -> ())
}

protocol BattleDataManager {
    func fetchAllBattles() -> [Battle]
    func createBattle(id: Int, name: String, villain: Villain, superhero: Superhero, winner: String)
    //func deleteBattle() -> Bool
}

