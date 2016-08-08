//
//  WebService.swift
//  babylon-test
//
//  Created by James Milton on 30/06/2016.
//  Copyright © 2016 james milton. All rights reserved.
//

import UIKit

typealias JSONDictionary = [String: AnyObject]

struct Resource<A> {
    let endpoint: Endpoint
    let parse: NSData -> A?
}

class AppWebService: WebService {
    
    let baseURL = "http://jsonplaceholder.typicode.com"
    
    func load<A>(resource: Resource<A>, completion: (A?, Error?) -> ()) {
        let urlString = baseURL.stringByAppendingString("/\(resource.endpoint.rawValue)")
        guard let url = NSURL(string: urlString) else {
            completion(nil, .GeneralError)
            return
        }
        
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        NSURLSession.sharedSession().dataTaskWithURL(url) { data, _, error in
            dispatch_async(dispatch_get_main_queue(), { 
                let result = data.flatMap(resource.parse)
                completion(result, self.parseURLSessionError(error))
                UIApplication.sharedApplication().networkActivityIndicatorVisible = false
            })
        }.resume()
    }
    
    func parseURLSessionError(error: NSError?) -> Error? {
        if let error = error {
            if error.code == NSURLErrorNotConnectedToInternet {
                return .NoNetwork
            } else {
                return .GeneralError
            }
        } else {
            return nil
        }
    }
}
