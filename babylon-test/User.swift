//
//  User.swift
//  babylon-test
//
//  Created by James Milton on 30/06/2016.
//  Copyright © 2016 james milton. All rights reserved.
//

import Foundation
import RealmSwift
import Unbox

final class User: Object, Unboxable {
    
    dynamic var id = 0
    dynamic var name: String = ""
    dynamic var username: String = ""
    dynamic var email: String = ""
    dynamic var address: UserAddress?
    dynamic var phone: String = ""
    dynamic var website: String = ""
    dynamic var company: UserCompany?
    
    required convenience init(unboxer: Unboxer) {
        self.init()
        self.id = unboxer.unbox("id")
        self.name = unboxer.unbox("name")
        self.username = unboxer.unbox("username")
        self.email = unboxer.unbox("email")
        self.address = unboxer.unbox("address")
        self.phone = unboxer.unbox("phone")
        self.website = unboxer.unbox("website")
        self.company = unboxer.unbox("company")
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

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
