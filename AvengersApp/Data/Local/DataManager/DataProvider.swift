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
    func fetchSuperhero(byID id: Int) -> Superhero? {
        guard let superhero = self.database?.fetchSuperhero(byID: id) as? Superhero else { return nil }
        return superhero
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
    func fetchVillain(byID id: Int) -> Villain? {
        guard let superhero = self.database?.fetchVillain(byID: id) as? Villain else { return nil }
        return superhero
    }
    
    func changePowerVillain(_ power: Int, withID id: Int, completion: @escaping (Bool) -> ()) {
        guard let result = self.database?.changeVillainPower(power, withID: id) else { completion(false);return }
        completion(result)
    }
    
}

extension DataProvider: BattleDataManager {
 
    func deleteBattle() -> Bool {
        return false
    }
}
