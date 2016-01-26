//
//  ViewController.swift
//  WeatherApp
//
//  Created by Jesse Tellez on 1/13/16.
//  Copyright © 2016 SunCat Developers. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    @IBOutlet weak var passwordTxtFeild: UITextField!
    @IBOutlet weak var usernameTxtFeild: UITextField!
    
    var username2: String!
    var password2: String!
    
    var user2: User!
    var weather2: Weather!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func logonPressed(sender: AnyObject) {
        
        if let name = usernameTxtFeild.text, pass = passwordTxtFeild.text as String? {
            if name == "" || name.isEmpty {
                let alert = UIAlertController(title: "Oops", message: "please enter a username", preferredStyle: .Alert)
                let action = UIAlertAction(title: "OK", style: .Default, handler: { _ in
                    
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
            } else {
                username2 = name.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
                password2 = pass.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
                //find someway to fill the user object to use the login method
              
                user2 = User(withUsername: username2, andPassword: password2)
                user2.loginUser({ () -> () in
                    if self.user2.auth == true {
                        self.user2.getUserData({ () -> () in
                            let vc = self.storyboard?.instantiateViewControllerWithIdentifier("weatherVC") as! WeatherVC
                            vc.userofpoop = self.user2
                            self.showViewController(vc, sender: vc)
                        })
                    }else {
                        let alert = UIAlertController(title: "Oops", message: "That information in incorrect", preferredStyle: .Alert)
                        let action = UIAlertAction(title: "OK", style: .Default, handler: { _ in
                            
                        })
                        alert.addAction(action)
                        self.presentViewController(alert, animated: true){}
                    }

                })
            }
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toWeatherView" {
            if let weather = segue.destinationViewController as? WeatherVC {
                if let userz = sender as? User {
                    //setup info for the weather controller
                    weather.userofpoop = userz
                }
            }
        }
    }

}

