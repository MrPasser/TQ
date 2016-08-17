//
//  CreativeAccount.swift
//  TQ
//
//  Created by Sviatoslav Krasin on 17.08.16.
//  Copyright © 2016 Sviatoslav Krasin. All rights reserved.
//

import UIKit

class CreateAccountViewController: UIViewController {
    @IBAction func createAccount(sender: AnyObject) {
        let username = usernameField.text
        let email = emailField.text
        let password = passwordField.text
        
        if username != "" && email != "" && password != "" {
            
            // Set Email and Password for the New User.
            
            DataService.dataService.BASE_REF.createUser(email, password: password, withValueCompletionBlock: { error, result in
                
                if error != nil {
                    
                    // There was a problem.
                    self.signupErrorAlert("Oops!", message: "Having some trouble creating your account. Try again.")
                    
                } else {
                    
                    // Create and Login the New User with authUser
                    DataService.dataService.BASE_REF.authUser(email, password: password, withCompletionBlock: {
                        err, authData in
                        
                        let user = ["provider": authData.provider!, "email": email!, "username": username!]
                        
                        // Seal the deal in DataService.swift.
                        DataService.dataService.createNewAccount(authData.uid, user: user)
                    })
                    
                    // Store the uid for future access - handy!
                    NSUserDefaults.standardUserDefaults().setValue(result ["uid"], forKey: "uid")
                    
                    // Enter the app.
                    self.performSegueWithIdentifier("NewUserLoggedIn", sender: nil)
                }
            })
            
        } else {
            signupErrorAlert("Oops!", message: "Don't forget to enter your email, password, and a username.")
        }
        
    }
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        // If we have the uid stored, the user is already logger in - no need to sign in again!
        
        if NSUserDefaults.standardUserDefaults().valueForKey("uid") != nil && DataService.dataService.CURRENT_USER_REF.authData != nil {
            self.performSegueWithIdentifier("CurrentlyLoggedIn", sender: nil)
        }
    }

}

func signupErrorAlert(title: String, message: String) {
    
    // Called upon signup error to let the user know signup didn't work.
    
    let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
    let action = UIAlertAction(title: "Ok", style: .Default, handler: nil)
    alert.addAction(action)
    presentViewController(alert, animated: true, completion: nil)
}

@IBAction func tryLogin(sender: AnyObject) {
    
    let email = emailField.text
    let password = passwordField.text
    
    if email != "" && password != "" {
        
        // Login with the Firebase's authUser method
        
        DataService.dataService.BASE_REF.authUser(email, password: password, withCompletionBlock: { error, authData in
            
            if error != nil {
                print(error)
                self.loginErrorAlert("Oops!", message: "Check your username and password.")
            } else {
                
                // Be sure the correct uid is stored.
                
                NSUserDefaults.standardUserDefaults().setValue(authData.uid, forKey: "uid")
                
                // Enter the app!
                
                self.performSegueWithIdentifier("CurrentlyLoggedIn", sender: nil)
            }
        })
        
    } else {
        
        // There was a problem
        
        loginErrorAlert("Oops!", message: "Don't forget to enter your email and password.")
    }
}

func loginErrorAlert(title: String, message: String) {
    
    // Called upon login error to let the user know login didn't work.
    
    let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
    let action = UIAlertAction(title: "Ok", style: .Default, handler: nil)
    alert.addAction(action)
    presentViewController(alert, animated: true, completion: nil)
}

