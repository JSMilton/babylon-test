//
//  NSBundleExtensions.swift
//  babylon-test
//
//  Created by James Milton on 08/08/2016.
//  Copyright © 2016 james milton. All rights reserved.
//

import Foundation

extension NSBundle {
    
    func JSONObjectWithName<A>(name: String) -> A {
        let fileURL = URLForResource(name, withExtension: "json")
        guard let url = fileURL else {
            fatalError("failed to create file url")
        }
        
        guard let data = NSData(contentsOfURL: url) else {
            fatalError("failed to get data")
        }
        
        do {
            guard let object = try NSJSONSerialization.JSONObjectWithData(data, options: []) as? A else { fatalError("json on file doesnt match type") }
            return object
        } catch {
            fatalError("error creating json object")
        }
    }
}