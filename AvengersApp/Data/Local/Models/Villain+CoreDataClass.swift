//
//  Villain+CoreDataClass.swift
//  AvengersApp
//
//  Created by Eva Gonzalez Ferreira on 01/05/2020.
//  Copyright © 2020 Eva Gonzalez Ferreira. All rights reserved.
//
//

import UIKit
import CoreData

@objc(Villain)
public class Villain: NSManagedObject {
    required convenience public init(from decoder: Decoder) throws {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate,
              let entity = NSEntityDescription.entity(forEntityName: "Villain", in: appDelegate.persistentContainer.viewContext) else {  fatalError("Failed to decode Subject!")  }
        self.init(entity: entity, insertInto: nil)
        
        let values = try decoder.container(keyedBy: VCodingKeys.self)
        
        self.id = try values.decode(Int16.self, forKey: .id)
        self.image = try values.decode(String.self, forKey: .image)
        self.name = try values.decode(String.self, forKey: .name)
        self.power = try values.decode(Int16.self, forKey: .power)
        self.villainDescription = try values.decode(String.self, forKey: .villainDescription)
    }
}
