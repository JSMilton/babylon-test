//
//  HTTPClient.swift
//  babylon-test
//
//  Created by James Milton on 08/08/2016.
//  Copyright © 2016 james milton. All rights reserved.
//

import Foundation

protocol WebService {
    func load<A>(resource: Resource<A>, completion: (A?, Error?) -> ())
}

class HTTPClient {
    
    let webService: WebService
    
    init(webService: WebService) {
        self.webService = webService
    }
    
    func load<A>(resource: Resource<A>, completion: (A?, Error?) -> ()) {
        webService.load(resource, completion: completion)
    }
}