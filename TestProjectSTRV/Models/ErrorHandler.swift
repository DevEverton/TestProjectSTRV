//
//  ErrorHandler.swift
//  TestProjectSTRV
//
//  Created by Everton Carneiro on 30/11/17.
//  Copyright © 2017 Everton. All rights reserved.
//

import Foundation

enum ErrorHandler: String, Error {
    
    case locationError = "Location Unavailable"
    case networkingError = "Response Fail"
    case invalidData = "Invalid Data"
    
}
