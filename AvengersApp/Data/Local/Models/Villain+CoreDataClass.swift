//
//  Villain+CoreDataClass.swift
//  AvengersApp
//
//  Created by Eva Gonzalez Ferreira on 25/04/2020.
//  Copyright © 2020 Eva Gonzalez Ferreira. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Villain)
public class Villain: NSManagedObject, Codable {

    @NSManaged public var id: Int16
    @NSManaged public var image: String?
    @NSManaged public var name: String?
    @NSManaged public var power: Int16
    @NSManaged public var villainDescription: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case image = "image"
        case power = "power"
        case villainDescription = "villainDescription"
        //case battles
    }
    
    required convenience public init(from decoder: Decoder) throws {
        self.init()
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try values.decode(Int16.self, forKey: .id)
        self.image = try values.decode(String.self, forKey: .image)
        self.name = try values.decode(String.self, forKey: .name)
        self.power = try values.decode(Int16.self, forKey: .power)
        self.villainDescription = try values.decode(String.self, forKey: .villainDescription)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.name, forKey: .name)
        try container.encode(self.image, forKey: .image)
        try container.encode(self.name, forKey: .name)
        try container.encode(self.power, forKey: .power)
        try container.encode(self.villainDescription, forKey: .villainDescription)
    }
}
