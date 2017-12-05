//
//  ForecastVC.swift
//  TestProjectSTRV
//
//  Created by Everton Carneiro on 29/11/17.
//  Copyright © 2017 Everton. All rights reserved.
//

import UIKit
import CoreLocation

class ForecastVC: UIViewController, CLLocationManagerDelegate, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var topBarTitle: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Weather.forecast.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let weatherCell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as? ForecastCell else { fatalError() }
        
        let weather = Weather.forecast[indexPath.row]
        let weekDays = getDaysofWeek()[indexPath.row]
        
        topBarTitle.text = weather.cityName
        weatherCell.weatherImage.image = weather.icon
        weatherCell.day.text = weekDays
        weatherCell.condition.text = weather.mainCondition
        weatherCell.temperature.text = String(Int(weather.temperature.kelvinToCelsius)) + "º"
        
        return weatherCell
    }
    
    func getDaysofWeek() -> [String] {
        let date = Date()
        let identifier = Calendar.Identifier.gregorian
        let calendar = Calendar(identifier: identifier )
        let component = calendar.component(.weekday, from: date)
        
        switch component {
        case 1: return ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
        case 2: return ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
        case 3: return ["Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday", "Monday"]
        case 4: return ["Wednesday", "Thursday", "Friday", "Saturday", "Sunday", "Monday", "Tuesday"]
        case 5: return ["Thursday", "Friday", "Saturday", "Sunday", "Monday", "Tuesday", "Wednesday"]
        case 6: return ["Friday", "Saturday", "Sunday", "Monday", "Tuesday", "Wednesday", "Thursday"]
        case 7: return ["Saturday", "Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday"]
        default: break
        }
        return []
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }


}
