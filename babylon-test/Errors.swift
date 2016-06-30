//
//  Errors.swift
//  babylon-test
//
//  Created by James Milton on 30/06/2016.
//  Copyright © 2016 james milton. All rights reserved.
//

import Foundation

enum Error: String, ErrorType {
    case NoNetwork = "You have no network connection. Please connect and try again."
    case GeneralError = "Something has gone wrong. Please try again later."
}