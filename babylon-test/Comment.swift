//
//  Comment.swift
//  babylon-test
//
//  Created by James Milton on 30/06/2016.
//  Copyright © 2016 james milton. All rights reserved.
//

import Foundation
import RealmSwift
import Unbox

class Comment: Object, Unboxable {
    
    dynamic var id = 0
    dynamic var postId = 0
    dynamic var name: String?
    dynamic var email: String?
    dynamic var body: String?
    
    required convenience init(unboxer: Unboxer) {
        self.init()
        self.id = unboxer.unbox("id")
        self.postId = unboxer.unbox("postId")
        self.name = unboxer.unbox("name")
        self.email = unboxer.unbox("email")
        self.body = unboxer.unbox("body")
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

extension Comment {
    static let all = Resource<[Comment]>(endpoint: .Comments) { data in
        do {
            let posts: [Comment] = try Unbox(data)
            return posts
        } catch {
            return nil
        }
    }
}