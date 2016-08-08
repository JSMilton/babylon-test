//
//  CommentResourceExtensions.swift
//  babylon-test
//
//  Created by James Milton on 08/08/2016.
//  Copyright © 2016 james milton. All rights reserved.
//

import Foundation
import Unbox

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