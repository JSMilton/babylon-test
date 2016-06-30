//
//  UserCompany.swift
//  babylon-test
//
//  Created by James Milton on 30/06/2016.
//  Copyright © 2016 james milton. All rights reserved.
//

import Foundation
import RealmSwift
import Unbox

final class UserCompany: Object, Unboxable {
    
    dynamic var name = ""
    dynamic var catchphrase = ""
    dynamic var bs = ""
    
    required convenience init(unboxer: Unboxer) {
        self.init()
        self.name = unboxer.unbox("name")
        self.catchphrase = unboxer.unbox("catchPhrase")
        self.bs = unboxer.unbox("bs")
    }
}
