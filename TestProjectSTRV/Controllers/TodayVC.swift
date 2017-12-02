//
//  TodayVC.swift
//  TestProjectSTRV
//
//  Created by Everton Carneiro on 29/11/17.
//  Copyright © 2017 Everton. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire
import SwiftyJSON


class TodayVC: UIViewController, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpLocationManager()
        
    }
    
    func getWeatherData(url: String, parameters: [String:Any]) {
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON {
            response in
            if response.result.isSuccess {
                let weatherJSON: JSON = JSON(response.result.value!)
                self.updateWeatherData(json: weatherJSON)
                
            }else {
                self.createAlert(withTitle: "Networking Error", message: ErrorHandler.networkingError.rawValue, actionTitle: "Ok")
            }
        }
        
    }
    
    func updateWeatherData(json: JSON) {
        
        let iconID = json["list"][0]["weather"][0]["icon"].string
        let icon = Weather.icons[iconID!]
        let cityName = json["city"]["name"].string
        let temperature = json["list"][0]["temp"]["max"].double
        let mainCondition = json["list"][0]["weather"][0]["main"].string
        let description = json["list"][0]["weather"][0]["description"].string
        let clouds = json["list"][0]["clouds"].double
        let rain = json["list"][0]["rain"].double ?? 0
        let pressure = json["list"][0]["pressure"].double
        let windSpeed = json["list"][0]["speed"].double
        let windDirection = json["list"][0]["deg"].double
        
        
        let todayWeather = Weather(icon: icon!, cityName: cityName!, temperature: temperature!, mainCondition: mainCondition!, description: description!, clouds: clouds!, rain: rain, pressure: pressure!, windSpeed: windSpeed!, windDirection: windDirection!)

        print(todayWeather)

    }
    

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations[locations.count - 1]
        if location.horizontalAccuracy > 0 {
            locationManager.stopUpdatingLocation()
            locationManager.delegate = nil
            Location.latitude = location.coordinate.latitude
            Location.longitude = location.coordinate.longitude
            
            print("Latitude: \(Location.latitude), Longtude: \(Location.longitude)")
            
            getWeatherData(url: Network.url, parameters: Location.parameters)
            
        }
        
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        createAlert(withTitle: "Error", message: ErrorHandler.locationError.rawValue, actionTitle: "Ok")

    }
    
    func setUpLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func createAlert(withTitle title: String, message: String, actionTitle: String ) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: actionTitle, style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }

    

}
