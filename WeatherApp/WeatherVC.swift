//
//  WeatherVC.swift
//  WeatherApp
//
//  Created by Jesse Tellez on 1/15/16.
//  Copyright © 2016 SunCat Developers. All rights reserved.
//

import UIKit

class WeatherVC: UIViewController {

    @IBOutlet weak var datLabel: UILabel!
    
    //userGreetingLabel == cityLabel instead
    @IBOutlet weak var userGreetingLabel: UILabel!
    
    @IBOutlet weak var percipitationLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    
    @IBOutlet weak var temperatureLabel: UILabel!
    
    var userofpoop: User!
    var weather: Weather!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userGreetingLabel.text = userofpoop.username
        
        weather = Weather(zipcode: userofpoop.location, countryCode: userofpoop.countryId)
        weather.downloadWeatherData { () -> () in
            self.updateUI()
        }
        
    }
    
    func updateUI() {
        percipitationLabel.text = weather.humidity
        windSpeedLabel.text = weather.windspeed
        temperatureLabel.text = weather.temp
    }
    
    
    @IBAction func signoutBthPressed(sender: AnyObject) {
        userofpoop.logOutUser { () -> () in
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
}
