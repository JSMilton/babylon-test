//
//  RealmDatabase.swift
//  babylon-test
//
//  Created by James Milton on 08/08/2016.
//  Copyright © 2016 james milton. All rights reserved.
//

import Foundation
import RealmSwift

class RealmDatabase: DatabaseType {
    func updateObjects(objects: [Object]) {
        let queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
        dispatch_async(queue) {
            do {
                let realm = try Realm()
                try realm.write {
                    realm.add(objects, update: true)
                }
            } catch {
                print(error)
            }
        }
    }
}
