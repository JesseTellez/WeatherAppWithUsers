//
//  Weather.swift
//  WeatherApp
//
//  Created by Jesse Tellez on 1/13/16.
//  Copyright © 2016 SunCat Developers. All rights reserved.
//

import Foundation
import Alamofire

//weather app api key &appid=50cf20013acb86e6cb271285d6e7eb28

class Weather {
    
    private var _description: String!
    private var _cityName: String!
    private var _humidity: String!
    private var _temp: Double!
    private var _country: String!
    private var _windSpeed: String!
    
    var humidity: String {
        return _humidity
    }
    var temp: String {
        return "\(_temp)"
    }
    var windspeed: String {
        return _windSpeed
    }
    
    private var _weatherURL: String!
    
    init(zipcode: String, countryCode: String) {
        _weatherURL = "\(URL_BASE)\(zipcode),\(countryCode)\(URL_END)"
    }
    
    func downloadWeatherData(completed: DownloadComplete) {
        let url = NSURL(string: _weatherURL)!
        
        Alamofire.request(.GET, url).responseJSON { response in
            let result = response.result
            
            if let dict = result.value as? Dictionary<String, AnyObject> {
                
                if let cityname = dict["name"] as? String {
                    self._cityName = cityname
                }
                
                if let main = dict["main"] as? Dictionary<String, Double> {
                    if let hum = main["humidity"] {
                        self._humidity = "\(hum)"
                    }
                    if let temp = main["temp"] {
                        self._temp = temp - 273.15
                    }
                }
                
                if let wind  = dict["wind"] as? Dictionary<String, Double> {
                    if let speed = wind["speed"] {
                        self._windSpeed = "\(speed)"
                    }
                }
            }
            completed()
        }
    }
    
}