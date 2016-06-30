//
//  HomeLoader.swift
//  babylon-test
//
//  Created by James Milton on 30/06/2016.
//  Copyright © 2016 james milton. All rights reserved.
//

import Foundation
import RealmSwift

final class PostViewModel: ViewModelType {
    
    var loading = false
    var users: Results<User>
    var posts: Results<Post>
    var webService = WebService()
    
    init() {
        let realm = try! Realm()
        self.users = realm.objects(User.self)
        self.posts = realm.objects(Post.self)
    }
    
    func load(completion:(()->())?) {
        loading = true
        webService.load(User.all) { users in
            self.webService.load(Post.all) { posts in
                if let users = users, posts = posts {
                    var allObjects = [Object]()
                    allObjects.appendContentsOf(users as [Object])
                    allObjects.appendContentsOf(posts as [Object])
                    self.updateObjects(allObjects)
                } else {
                    // handle error
                }
                self.loading = false
                completion?()
            }
        }
    }
}
