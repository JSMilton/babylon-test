//
//  ViewModelType.swift
//  babylon-test
//
//  Created by James Milton on 30/06/2016.
//  Copyright © 2016 james milton. All rights reserved.
//

import Foundation
import RealmSwift

protocol ViewModelType {
    var loading: Bool { get }
    var httpClient: HTTPClient { get set }
    func load(completion: ((Error?)->())?)
    func updateObjects(objects: [Object])
}

extension ViewModelType {
    
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
