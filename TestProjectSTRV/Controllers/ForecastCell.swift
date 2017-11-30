//
//  ForecastCell.swift
//  TestProjectSTRV
//
//  Created by Everton Carneiro on 29/11/17.
//  Copyright © 2017 Everton. All rights reserved.
//

import UIKit

class ForecastCell: UITableViewCell {
    
    @IBOutlet weak var temperature: UILabel!
    @IBOutlet weak var day: UILabel!
    @IBOutlet weak var condition: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
