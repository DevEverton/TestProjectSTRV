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
    
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var cityCountry: UILabel!
    @IBOutlet weak var temperatureCondition: UILabel!
    @IBOutlet weak var clouds: UILabel!
    @IBOutlet weak var rain: UILabel!
    @IBOutlet weak var pressure: UILabel!
    @IBOutlet weak var windSpeed: UILabel!
    @IBOutlet weak var windDirection: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpLocationManager()
        
    }
    
    typealias kelvin = Double
    
    func updateUI() {
        
        let forecast = Weather.forecast[0]
        icon.image = forecast.icon
        cityCountry.text = forecast.cityName + ", " + forecast.country
        temperatureCondition.text = String(Int(forecast.temperature.kelvinToCelsius)) + "ºC || " + forecast.mainCondition
        clouds.text = String(Int(forecast.clouds)) + "%"
        rain.text = String(forecast.rain) + " mm"
        pressure.text = String(Int(forecast.pressure)) + " hPa"
        windSpeed.text = String(Int(forecast.windSpeed.msToKmh)) + "Km/h"
        windDirection.text = String(getDirection(degree: forecast.windDirection))
        
        
    }
    
    func getDirection(degree: Double) -> String {
        
        switch degree {
        case 0.0: return "N"
        case 1.0...89.9: return "NE"
        case 90.0: return "E"
        case 91.0...179.9: return "SE"
        case 180.0: return "S"
        case 181.0...269.9: return "SO"
        case 270.0: return "O"
        case 271.0...359.9: return "NO"
        case 360.0: return "N"
        default: break
        }
        return "Error"
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

        //Generating an array of the 7 days forecast
        for i in 0...6 {
            
            let iconID = json["list"][i]["weather"][0]["icon"].string
            let icon = Weather.icons[iconID!]
            let cityName = json["city"]["name"].string
            let country = json["city"]["country"].string
            let temperature = json["list"][i]["temp"]["max"].double
            let mainCondition = json["list"][i]["weather"][0]["main"].string
            let description = json["list"][i]["weather"][0]["description"].string
            let clouds = json["list"][i]["clouds"].double
            let rain = json["list"][i]["rain"].double ?? 0
            let pressure = json["list"][i]["pressure"].double
            let windSpeed = json["list"][i]["speed"].double
            let windDirection = json["list"][i]["deg"].double
            
            Weather.forecast.append(Weather(icon: icon!, cityName: cityName!, country: country!, temperature: temperature!, mainCondition: mainCondition!, description: description!, clouds: clouds!, rain: rain, pressure: pressure!, windSpeed: windSpeed!, windDirection: windDirection!))
            
           updateUI()
            
        }

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
