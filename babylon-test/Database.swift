//
//  Database.swift
//  babylon-test
//
//  Created by James Milton on 08/08/2016.
//  Copyright © 2016 james milton. All rights reserved.
//

import Foundation

protocol DatabaseType {
    associatedtype ItemType
    func updateObjects(objects: [ItemType])
}

class Database<Type: DatabaseType> {
    
    let database: Type
    
    init(database: Type) {
        self.database = database
    }
    
    func updateObjects(objects: [Type.ItemType]) {
        self.database.updateObjects(objects)
    }
}
