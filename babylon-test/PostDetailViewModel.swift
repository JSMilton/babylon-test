//
//  PostDetailViewModel.swift
//  babylon-test
//
//  Created by James Milton on 30/06/2016.
//  Copyright © 2016 james milton. All rights reserved.
//

import Foundation
import RealmSwift

class PostDetailViewModel: ViewModelType {
    
    let post: Post
    let user: User
    var comments: Results<Comment>?
    var loading: Bool = false
    var httpClient = HTTPClient(webService: AppWebService())
    
    init(post: Post, user: User) {
        self.post = post
        self.user = user
        
        let realm = try! Realm()
        self.comments = realm.objects(Comment.self)
    }
    
    func load(completion: ((Error?)->())?) {
        loading = true
        httpClient.load(Comment.all) { (comments, error) in
            if let comments = comments {
                self.updateObjects(comments)
            }
            
            completion?(error)
        }
    }

}