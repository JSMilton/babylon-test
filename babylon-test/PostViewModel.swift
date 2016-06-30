//
//  HomeLoader.swift
//  babylon-test
//
//  Created by James Milton on 30/06/2016.
//  Copyright © 2016 james milton. All rights reserved.
//

import Foundation
import RealmSwift

final class PostViewModel {
    
    var loading = false
    var users: Results<User>
    var posts: Results<Post>
    let webService = WebService()
    
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
                    self.updateRealm(users, posts: posts)
                } else {
                    // handle error
                }
                self.loading = false
                completion?()
            }
        }
    }
    
    func updateRealm(users: [User], posts: [Post]) {
        let queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
        dispatch_async(queue) {
            do {
                let realm = try Realm()
                try realm.write {
                    for user in users {
                        realm.add(user, update: true)
                    }
                    
                    for post in posts {
                        realm.add(post, update: true)
                    }
                }
                
            } catch {
                // handle error
            }
        }
    }
}
