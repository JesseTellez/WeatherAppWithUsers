//
//  SignUpVC.swift
//  WeatherApp
//
//  Created by Jesse Tellez on 1/13/16.
//  Copyright © 2016 SunCat Developers. All rights reserved.
//

import UIKit

class SignUpVC: UIViewController {

    @IBOutlet weak var userNameTxtFeild: UITextField!
    @IBOutlet weak var passwordTxtField: UITextField!
    @IBOutlet weak var locationTxtField: UITextField!
    @IBOutlet weak var countryCodeTxtFeild: UITextField!
    
    private var _username: String!
    private var _password: String!
    private var _location: String!
    private var _country: String!
    
    var newUser: User!
    
    @IBAction func finishBtnPressed(sender: AnyObject) {
        print(userNameTxtFeild.text)
        if let text = userNameTxtFeild.text, let pass = passwordTxtField.text, let location = locationTxtField.text, country = countryCodeTxtFeild.text as String? {
            if text == "" || text.isEmpty {
                print(text)
                let alert = UIAlertController(title: "Opps!", message: "please enter a username", preferredStyle: .Alert)
                let action = UIAlertAction(title: "OK", style: .Default, handler: { _ in
                    //put any code that you would like to execute when user taps the button
                })
                alert.addAction(action)
                self.presentViewController(alert, animated: true){}
            }
            else if pass == "" || pass.isEmpty {
                let alert = UIAlertController(title: "Oops", message: "please enter a password", preferredStyle: .Alert)
                let action = UIAlertAction(title: "OK", style: .Default, handler: { _ in
                    
                })
                alert.addAction(action)
                self.presentViewController(alert, animated: true){}
            }
            else if location == "" || location.isEmpty {
                let alert = UIAlertController(title: "Oops", message: "please enter a location", preferredStyle: .Alert)
                let action = UIAlertAction(title: "OK", style: .Default, handler: { _ in
                    
                })
                alert.addAction(action)
                self.presentViewController(alert, animated: true){}
            }
            else if country == "" || country.isEmpty {
                let alert = UIAlertController(title: "Oops", message: "please enter a country code", preferredStyle: .Alert)
                let action = UIAlertAction(title: "OK", style: .Default, handler: { _ in
                    
                })
                alert.addAction(action)
                self.presentViewController(alert, animated: true){}
            }
            else{
                _username = text.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
                _password = pass.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
                _location = location.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
                _country = country.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
                newUser = User(username: _username, password: _password, zipCode: _location, countryId: _country)
                //createUser(_username, pass: _password, location: _location, country: _country)
                dismissViewControllerAnimated(true, completion: nil)
            }
        }
        
        
    }
    
    @IBAction func backBtnPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func createUser(username: String, pass: String, location: String, country: String) {
        newUser = User(username: username, password: pass, zipCode: location, countryId: country)
    }
}
