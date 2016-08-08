//
//  UserResourceExtensions.swift
//  babylon-test
//
//  Created by James Milton on 08/08/2016.
//  Copyright © 2016 james milton. All rights reserved.
//

import Foundation
import Unbox

extension User {
    static let all = Resource<[User]>(endpoint: .Users) { data in
        do {
            let users: [User] = try Unbox(data)
            return users
        } catch {
            return nil
        }
    }
}
