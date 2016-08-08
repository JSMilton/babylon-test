//
//  babylon_testTests.swift
//  babylon-testTests
//
//  Created by James Milton on 08/08/2016.
//  Copyright © 2016 james milton. All rights reserved.
//

import Quick
import Nimble
import Unbox

class UserSpec: QuickSpec {
    
    let userJSON: [String: AnyObject] = NSBundle(forClass: object_getClass(UserSpec)).JSONObjectWithName("single-user")
    
    override func spec() {
        
        it("parses a single user correctly") {
            let user: User = try! Unbox(self.userJSON)
            expect(user.id).to(equal(1))
            expect(user.name).to(equal("Leanne Graham"))
            expect(user.username).to(equal("Bret"))
            expect(user.email).to(equal("Sincere@april.biz"))
        }
    }
}