//
//  WebService.swift
//  babylon-test
//
//  Created by James Milton on 30/06/2016.
//  Copyright © 2016 james milton. All rights reserved.
//

import Foundation

typealias JSONDictionary = [String: AnyObject]

struct Resource<A> {
    let endpoint: Endpoint
    let parse: NSData -> A?
}

final class WebService {
    
    let baseURL = "http://jsonplaceholder.typicode.com"
    
    func load<A>(resource: Resource<A>, completion: A? -> ()) {
        let urlString = baseURL.stringByAppendingString("/\(resource.endpoint.rawValue)")
        guard let url = NSURL(string: urlString) else {
            completion(nil)
            return
        }
        
        NSURLSession.sharedSession().dataTaskWithURL(url) { data, _, _ in
            let result = data.flatMap(resource.parse)
            completion(result)
        }.resume()
    }
}
