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
    
    
    
    
    @IBAction func RegistrationButton(sender: UIButton) {
        
        
        
        let allertController = UIAlertController(title: "Вход", message: "Введите данные для входа", preferredStyle: .Alert)
        
        let  allertOkAction = UIAlertAction(title: "Enter", style: .Default, handler: nil)
        
        allertController.addAction(allertOkAction)
        
        allertController.addTextFieldWithConfigurationHandler { ( loginTF) in
            loginTF.placeholder = "Ваш логин"}
        
        allertController.addTextFieldWithConfigurationHandler { ( passwordTF) in
            passwordTF.placeholder = "Ваш пароль"
            passwordTF.secureTextEntry = true        }
        
        
        
        
        if loginField.text != nil && passwordField.text != nil {
            
            
            let login = loginField.text
            let password = passwordField.text
            
            print(login, password)
            
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
                    print("JSON2: \(JSON)")
                    
                }
                
                
                
            }
            
            
            
            presentViewController(allertController, animated: true, completion: nil)
            
        }
    }

    
 
    
    
    
    @IBAction func EnterBottom(sender: UIButton) {
        if loginField.text != nil && passwordField.text != nil {
            
            
            let login = loginField.text
            let password = passwordField.text
            
            let parameters = [
                "login" : login!,
                "password": password!
            ]
            //193.33.237.133:9090
            //http://sn-munchkin-server.cfapps.io/mobile/user/registration
            
            Alamofire.request(.POST, "http://sn-munchkin-server.cfapps.io/mobile/user/login", parameters: parameters, encoding: .JSON).responseJSON {
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
        
        
            
 
        
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    

}

