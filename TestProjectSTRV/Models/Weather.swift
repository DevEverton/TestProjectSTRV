//
//  Weather.swift
//  TestProjectSTRV
//
//  Created by Everton Carneiro on 30/11/17.
//  Copyright © 2017 Everton. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

struct Weather {
    
    let icon: UIImage
    let cityName: String
    let temperature: Double
    let mainCondition: String
    let description: String
    let clouds: Double
    let rain: Double
    let pressure: Double
    let windSpeed: Double
    let windDirection: Double
    
    static let icons = ["01d":#imageLiteral(resourceName: "Sun_Big"), "02d": #imageLiteral(resourceName: "Cloudy_Big"), "03d": #imageLiteral(resourceName: "Cloudy_Big"), "04d": #imageLiteral(resourceName: "Cloudy_Big"), "09d": #imageLiteral(resourceName: "Rain"), "10d": #imageLiteral(resourceName: "Rain"), "11d": #imageLiteral(resourceName: "CL"), "13d": #imageLiteral(resourceName: "CL")]
    
    
}





