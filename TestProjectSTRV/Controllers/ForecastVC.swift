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
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let weatherCell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as? ForecastCell else { fatalError() }
        
        weatherCell.weatherImage.image = #imageLiteral(resourceName: "Sun")
        weatherCell.day.text = "Monday"
        weatherCell.condition.text = "Sunny"
        
        return weatherCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
    



}
