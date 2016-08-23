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
    
<<<<<<< HEAD
    
    
    
    @IBAction func RegistrationButton(sender: UIButton) {
        
        
        
        let alertController = UIAlertController(title: "Вход", message: "Введите данные для регистрации", preferredStyle: .Alert)
        
        let  alertOkAction = UIAlertAction(title: "Enter", style: .Default, handler: nil)
        
=======
    @IBAction func Enter(sender: UIButton) {
        var loginTextField: UITextField!
        var passwordTextField: UITextField!
        let allertController = UIAlertController(title: "Вход", message: "Введите данные для входа", preferredStyle: .Alert)
        
        let allertOkAction = UIAlertAction(title: "Enter", style: .Default){(action) in
            if loginTextField.text != nil && passwordTextField.text != nil {
                let login = loginTextField.text
                let password = passwordTextField.text
                let parameters = [
                    "login" : login!,
                    "password": password!
                ]
                Alamofire.request(.POST, "http://sn-munchkin-server.cfapps.io/mobile/user/login", parameters: parameters, encoding: .JSON).responseJSON {
                    response in
                    //print(response.request)  // original URL request
                    print(response.response) // URL response
                    //print(response.data)     // server data
                    //print(response.result)   // result of response serialization
                    
                    if let JSON = response.result.value {
                        print("JSON2: \(JSON)")
                        
                    }
                }
            }
        }
        
        allertController.addAction(allertOkAction)
        allertController.addTextFieldWithConfigurationHandler { ( loginTF) in
            loginTF.placeholder = "Ваш логин"
            loginTextField = loginTF
        }
>>>>>>> origin/master
        
        alertController.addTextFieldWithConfigurationHandler { ( loginTF) -> Void in
            loginTF.text = ""
            loginTF.placeholder = "Ваш логин"}
        
        alertController.addTextFieldWithConfigurationHandler { ( passwordTF) -> Void in
            passwordTF.text = ""
            passwordTF.placeholder = "Ваш пароль"
<<<<<<< HEAD
            passwordTF.secureTextEntry = true        }
        
        alertController.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
            let loginTF = alertController.textFields![0] as UITextField
            
            let passwordTF = alertController.textFields![0] as UITextField //как заставить получить инфу из второго TF
            let parameters = [
                "login" : loginTF,
                "password": passwordTF
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
        }))

        
        
        
        
        
            
            
        
        
            

            
            
            
            presentViewController(alertController, animated: true, completion: nil)
            
=======
            passwordTF.secureTextEntry = true
            passwordTextField = passwordTF
        }
        presentViewController(allertController, animated: true, completion: nil)
>>>>>>> origin/master
        
    }
    
    @IBAction func EnterBottom(sender: UIButton) {
        if loginField.text != nil && passwordField.text != nil {
            
            
            let login = loginField.text
            let password = passwordField.text
            
            let parameters = [
                "login" : login!,
                "password": password!
            ]
            
            
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

