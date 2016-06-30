//
//  HomeLoader.swift
//  babylon-test
//
//  Created by James Milton on 30/06/2016.
//  Copyright © 2016 james milton. All rights reserved.
//

import Foundation
import RealmSwift

final class HomeLoader {
    
    let webService = WebService()
    
    func getCached() -> (Results<User>?, Results<Post>?) {
        do {
            let realm = try Realm()
            let users = realm.objects(User.self)
            let posts = realm.objects(Post.self)
            return (users, posts)
        } catch {
            return (nil, nil)
        }
    }
    
    func load() {
        webService.load(User.all) { users in
            self.webService.load(Post.all) { posts in
                if let users = users, posts = posts {
                    self.updateRealm(users, posts: posts)
                } else {
                    // handle error
                }
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
