//
//  Post.swift
//  babylon-test
//
//  Created by James Milton on 30/06/2016.
//  Copyright © 2016 james milton. All rights reserved.
//

import Foundation
import RealmSwift
import Unbox

class Post: Object, Unboxable {
    
    dynamic var id = 0
    dynamic var userId = 0
    dynamic var title: String?
    dynamic var body: String?
    
    required convenience init(unboxer: Unboxer) {
        self.init()
        self.id = unboxer.unbox("id")
        self.userId = unboxer.unbox("userId")
        self.title = unboxer.unbox("title")
        self.body = unboxer.unbox("body")
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
