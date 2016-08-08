//
//  PostResourceExtentions.swift
//  babylon-test
//
//  Created by James Milton on 08/08/2016.
//  Copyright © 2016 james milton. All rights reserved.
//

import Foundation
import Unbox

extension Post {
    static let all = Resource<[Post]>(endpoint: .Posts) { data in
        do {
            let posts: [Post] = try Unbox(data)
            return posts
        } catch {
            return nil
        }
    }
}