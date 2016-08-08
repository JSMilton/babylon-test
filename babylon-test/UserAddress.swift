//
//  UserAddress.swift
//  babylon-test
//
//  Created by James Milton on 30/06/2016.
//  Copyright © 2016 james milton. All rights reserved.
//

import Foundation
import RealmSwift
import Unbox

class UserAddress: Object, Unboxable {
    dynamic var street: String?
    dynamic var suite: String?
    dynamic var city: String?
    dynamic var zipcode: String?
    dynamic var geoLat: String?
    dynamic var geoLong: String?
    
    required convenience init(unboxer: Unboxer) {
        self.init()
        self.street = unboxer.unbox("street")
        self.suite = unboxer.unbox("suite")
        self.city = unboxer.unbox("city")
        self.zipcode = unboxer.unbox("zipcode")
        self.geoLat = unboxer.unbox("geo.lat")
        self.geoLong = unboxer.unbox("geo.lng")
    }
}
