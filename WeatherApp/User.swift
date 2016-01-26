//
//  User.swift
//  WeatherApp
//
//  Created by Jesse Tellez on 1/13/16.
//  Copyright © 2016 SunCat Developers. All rights reserved.
//

import Foundation
import Alamofire

class User {
    
    private var _username: String!
    private var _password: String!
    private var _zip: String!
    private var _countryID: String!
    private var _auth: Bool!
    
    var auth: Bool {
        if _auth == nil {
            _auth = false
        }
        return _auth
    }
    var username: String{
        if _username == nil {
            _username = "poop"
        }
        return _username
    }
    
    var password: String {
        if _password == nil {
            _password = "poopy"
        }
        return _password
    }
    
    var location: String {
        if _zip == nil {
            _zip = ""
        }
        return _zip
    }
    var countryId: String {
        if _countryID == nil {
            _countryID = ""
        }
        return _countryID
    }
    
    init(username: String, password: String, zipCode: String, countryId: String){
        self._username = username
        self._password = password
        self._zip = zipCode
        self._countryID = countryId
        createNewUser()
        
    }
    
    init(withUsername: String!, andPassword: String!) {
        self._username = withUsername
        self._password = andPassword
    }
    
    func createNewUser() {
        let url = SERVER_URL + REGISTER
        let parameters = [
            "username":_username,
            "password": _password,
            "zip": _zip,
            "countryId": _countryID,
        ]

        Alamofire.request(.POST, url, parameters: parameters, encoding:.JSON).responseString
        { response in switch response.result {
            case .Success(let JSON):
                print("Success with JSON: \(JSON)")
                
            case .Failure(let error):
                print(parameters)
                print("Request failed with error: \(error)")
          }
        }
        
    }
    
    func loginUser(completion: DownloadComplete) {
        
        let url = SERVER_URL + LOGIN
        
        let parameters = [
            "username":_username,
            "password": _password,
        ]
        
        Alamofire.request(.POST, url, parameters: parameters, encoding:.JSON).responseString
            { response in switch response.result {
            case .Success(let JSON):
                print("Success with JSON: \(JSON)")
                print("Response String: \(response.result.value)")
                //self._auth = true
                if let httpErr = response.result.error
                {
                    let statuscode = httpErr.code
                    print(statuscode)
                    self._auth = false
                }
                else
                {
                    let statusCode = (response.response?.statusCode)
                    if statusCode == 200
                    {
                        self._auth = true
                    }
                    else
                    {
                        self._auth = false
                    }
                }
            case .Failure(let error):
                print("Request failed with error: \(error)")
                self._auth = false
                
            }
            completion()
        }
    }
    
    
    func getUserData(completed: DownloadComplete) {
        //need to make parameters for the GET request
        let url = SERVER_URL + USERS
        let parameters = [
            "username": _username
        ]
        Alamofire.request(.GET, url, parameters: parameters).responseJSON { response in
            let result = response.result
            print(result)
            
            if let dict = result.value as? Dictionary<String, AnyObject> {
                if let zip = dict["zip"] as? String {
                    self._zip = zip
                }
                if let country = dict["countryId"] as? String {
                    self._countryID = country
                }
            }
            completed()
        }
    }
    func logOutUser(completed: DownloadComplete) {
        let url = SERVER_URL + USERS + LOGOUT
        let parameters = [
            "username": _username
        ]
        
        Alamofire.request(.POST, url, parameters: parameters, encoding: .JSON).responseJSON {
            response in switch response.result {
            case .Success(let JSON):
                print("Success with JSON: \(JSON)")
                print("Response String: \(response.result.value)")
            case .Failure(let error):
                print("Request failed with error: \(error)")
            }
            
            completed()
        }
    }
}
