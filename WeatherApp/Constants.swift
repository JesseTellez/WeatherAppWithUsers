//
//  Constants.swift
//  WeatherApp
//
//  Created by Jesse Tellez on 1/13/16.
//  Copyright © 2016 SunCat Developers. All rights reserved.
//

import Foundation

let URL_BASE = "http://api.openweathermap.org/data/2.5/weather?zip="
let URL_END = "&appid=50cf20013acb86e6cb271285d6e7eb28"

let SERVER_URL = "http://localhost:3000/"
let REGISTER = "signup"
let LOGIN = "login"
let USERS = "users/p/"
let LOGOUT = "logout"

typealias DownloadComplete = () -> ()
typealias UploadComplete = () -> ()