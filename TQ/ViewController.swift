//
//  ViewController.swift
//  TQ
//
//  Created by Sviatoslav Krasin on 17.08.16.
//  Copyright © 2016 Sviatoslav Krasin. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {
    
    @IBOutlet weak var loginField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var cpasswordField: UITextField!
 
    
    
    
    @IBAction func RegistrationButton(sender: UIButton) {
        if cpasswordField.text == passwordField.text && loginField.text != nil && passwordField.text != nil {
            
            
            let login = loginField.text
            let password = passwordField.text
            
            let parameters = [
                "login" : login!,
                "password": password!
            ]
            
            
            Alamofire.request(.POST, "http://sn-munchkin-server.cfapps.io/mobile/user/registration", parameters: parameters, encoding: .JSON).responseJSON {
                response in
                
                //print(response.request)  // original URL request
                print(response.response) // URL response
                //print(response.data)     // server data
                //print(response.result)   // result of response serialization
                
                if let JSON = response.result.value {
                    print("JSON: \(JSON)")
                }
            }

            
            
        }
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        /* Alamofire.request(.POST, "http://sn-munchkin-server.cfapps.io/mobile/user/login", parameters: parameters, encoding: .JSON).responseJSON {
            response in
            
            //print(response.request)  // original URL request
            print(response.response) // URL response
            //print(response.data)     // server data
            //print(response.result)   // result of response serialization
            
            if let JSON = response.result.value {
                print("JSON2: \(JSON)")
            }
        }*/
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

