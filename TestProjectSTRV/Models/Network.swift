//
//  Network.swift
//  TestProjectSTRV
//
//  Created by Everton Carneiro on 30/11/17.
//  Copyright © 2017 Everton. All rights reserved.
//

import Foundation

struct Network {
    
    static let appid = "e72ca729af228beabd5d20e3b7749713"
    static let url = "http://api.openweathermap.org/data/2.5/forecast/daily?lat=\(Location.latitude)&lon=\(Location.longitude)&cnt=7&APPID=\(appid)"
    
    
}
