//
//  DataProvider.swift
//  AvengersApp
//
//  Created by Eva Gonzalez Ferreira on 23/04/2020.
//  Copyright © 2020 Eva Gonzalez Ferreira. All rights reserved.
//

import Foundation

class DataProvider {
    private var database: DataBase? = nil
    
    init() {
        database = DataBase()
    }
    
    deinit {
        database = nil
    }
}

extension DataProvider: SuperherosDataManager {
    func fetchAllSuperHeroes() -> [Superhero] {
        guard let superheros = self.database?.fecthAllSuperheroData() as? [Superhero] else { return [] }
        return superheros
    }
    
    func initSuperheroData() {
        if self.fetchAllSuperHeroes().count == 0 {
            self.database?.initSuperheroData()
        }
    }
}

extension DataProvider: SuperheroDetailDataManager {
    func fetchSuperhero(byID id: Int) -> (Superhero, [Battle])? {
        guard let superhero = self.database?.fetchSuperhero(byID: id) as? Superhero,
              let battles = superhero.battles?.allObjects as? [Battle] else { return nil }
        return (superhero, battles)
    }
    
    func changePowerSuperhero(_ power: Int, withID id: Int, completion: @escaping (Bool) -> ()) {
        guard let result = self.database?.changeSuperheroPower(power, withID: id) else { completion(false);return }
        completion(result)
    }
    
}

extension DataProvider: VillainDataManager {
    func fetchAllVillains() -> [Villain] {
        guard let villains = self.database?.fecthAllVillainData() as? [Villain] else { return [] }
        return villains
    }
    
    func initVillainData() {
        if self.fetchAllVillains().count == 0 {
            self.database?.initVillainData()
        }
    }
}

extension DataProvider: VillainDetailDataManager {
    func fetchVillain(byID id: Int) -> (Villain, [Battle])? {
        guard let villain = self.database?.fetchVillain(byID: id) as? Villain,
              let battles = villain.battles?.allObjects as? [Battle] else { return nil }
        return (villain, battles)
    }
    
    func changePowerVillain(_ power: Int, withID id: Int, completion: @escaping (Bool) -> ()) {
        guard let result = self.database?.changeVillainPower(power, withID: id) else { completion(false);return }
        completion(result)
    }
    
}

extension DataProvider: BattleDataManager {
    
    func fetchAllBattles() -> [Battle] {
        guard let battles = self.database?.fecthAllBattleData() as? [Battle] else { return [] }
        return battles
    }
    
    func createBattle(id: Int, name: String, villain: Villain, superhero: Superhero, winner: String) {
        self.database?.createBattle(id: id, name: name, villain: villain, superhero: superhero, winner: winner)
    }
    
    func deleteBattle(_ battleID: Int) {
        self.database?.deleteBattle(Int16(battleID))
    }
}
