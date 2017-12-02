//
//  Location.swift
//  TestProjectSTRV
//
//  Created by Everton Carneiro on 30/11/17.
//  Copyright © 2017 Everton. All rights reserved.
//

import Foundation
import CoreLocation

struct Location {
    
    static var latitude = Double()
    static var longitude = Double()
    
    static var parameters: [String:Any] = ["lat":Location.latitude, "lon":Location.longitude]
 
}

