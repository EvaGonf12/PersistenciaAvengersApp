//
//  DataBase.swift
//  AvengersApp
//
//  Created by Eva Gonzalez Ferreira on 23/04/2020.
//  Copyright © 2020 Eva Gonzalez Ferreira. All rights reserved.
//

import UIKit
import CoreData

class DataBase {
    
    // MARK: - Managed Object Context
    private func context() -> NSManagedObjectContext? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return nil
        }
         
        return appDelegate.persistentContainer.viewContext
    }
    
    func persist() {
        guard let contextMOB = context() else {
            return
        }
        
        try? contextMOB.save()
    }
    
}

extension DataBase: BattleDataBase {
    var entityBattle: EntityEnum {
        return .Battle
    }
    
    func createBattle() -> NSManagedObject? {
        guard let contextMOB = context(),
            let entity = NSEntityDescription.entity(forEntityName: entityBattle.rawValue,
                                                      in: contextMOB) else {
            return nil
        }
        
        //return Battle(entity: entity,insertInto: context())
        return nil
    }
    
    func fecthAllBattleData() -> [NSManagedObject]? {
        guard let contextMOB = context() else { return nil }
        return try? contextMOB.fetch(NSFetchRequest<NSFetchRequestResult>(entityName: entityBattle.rawValue)) as? [NSManagedObject]
    }
    
    func deleteBattle(data: [NSManagedObject]) -> Bool {
        let contextMOB = context()
        data.forEach{ contextMOB?.delete($0) }
        
        print("Deleted objects: \(String(describing: contextMOB?.deletedObjects))")
        try? contextMOB?.save()
        return true
    }
}

extension DataBase: VillainDataBase {
    func changeVillainPower(_ power: Int, withID id: Int) -> Bool {
        return false
    }
    
    func createVillain() -> NSManagedObject? {
        return nil
    }
    
    var entityVillain: EntityEnum {
        return .Villain
    }
    
    func fecthAllVillainData() -> [NSManagedObject]? {
        guard let contextMOB = context() else { return nil }
        return try? contextMOB.fetch(NSFetchRequest<NSFetchRequestResult>(entityName: entityVillain.rawValue)) as? [NSManagedObject]
    }
}


extension DataBase: SuperheroDataBase {
    
    var entitySuperhero: EntityEnum {
        return .Superhero
    }
    
    func initSuperheroData() {
        if let pathSuperheros = Bundle.main.url(forResource: "superheros", withExtension: "json") {
            do {
                let data = try Data.init(contentsOf: pathSuperheros)
                let decoder = JSONDecoder()
                let superheros = try decoder.decode([Superhero].self, from: data)
                self.initSuperheroData(superheros)
            } catch {
                print(error)
            }
        } else {
            fatalError("No se pudo obtener el path de la url")
        }
    }
    
    func initSuperheroData(_ heros: [Superhero]) {
        guard let contextMOB = context(),
            let entity = NSEntityDescription.entity(forEntityName: entitySuperhero.rawValue,
                                                    in: contextMOB) else { return }
        
        for hero in heros {
            let newHero = Superhero(entity: entity, insertInto: contextMOB)
            newHero.id = hero.id
            newHero.name = hero.name
            newHero.image = hero.image
            newHero.power = hero.power
            newHero.superheroDescription = hero.superheroDescription
        }
    }
    
    func fecthAllSuperheroData() -> [NSManagedObject]? {
        guard let contextMOB = context() else { return nil }
        return try? contextMOB.fetch(NSFetchRequest<NSFetchRequestResult>(entityName: entitySuperhero.rawValue)) as? [NSManagedObject]
    }
    
    func fetchSuperhero(byID id: Int) -> NSManagedObject? {
        guard let contextMOB = context() else { return nil }
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entitySuperhero.rawValue)
        fetchRequest.predicate = NSPredicate(format: "id = \(id)")
        
        return try? contextMOB.fetch(fetchRequest).first as? NSManagedObject
    }
    
    func changeSuperheroPower(_ power: Int, withID id: Int) -> Bool {
        guard let superHero = fetchSuperhero(byID: id) else { return false }
        superHero.setValue(power, forKey: SuperheroKeysEnum.Power.rawValue)
        self.persist()
        return true
    }
}
