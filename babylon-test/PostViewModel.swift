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
    var httpClient = HTTPClient(webService: AppWebService())
    var database = Database(database: RealmDatabase())
    
    init() {
        let realm = try! Realm()
        self.users = realm.objects(User.self)
        self.posts = realm.objects(Post.self)
    }
    
    func load(completion:((Error?)->())?) {
        loading = true
        httpClient.load(User.all) { (users, error) in
            self.httpClient.load(Post.all) { (posts, error) in
                if let users = users, posts = posts {
                    self.database.updateObjects(users)
                    self.database.updateObjects(posts)
                }
                
                completion?(error)
                self.loading = false
            }
        }
    }
}
