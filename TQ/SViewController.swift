//
//  SViewController.swift
//  TQ
//
//  Created by Sviatoslav Krasin on 17.08.16.
//  Copyright © 2016 Sviatoslav Krasin. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


    
    private func deleteStepicCookiesForSignup() {
        //        let stepicURL = NSURL(string: "https://stepic.org/accounts/signup/?next=/")!
        let storage = NSHTTPCookieStorage.sharedHTTPCookieStorage()
        for cookie in storage.cookies ?? [] {
            if cookie.domain.rangeOfString("stepic") != nil {
                print("Deleting cookie with name: \(cookie.name), value: \(cookie.value)\n")
                storage.deleteCookie(cookie)
            }
        }
    }
    
    func refreshSignUpCookies(completion completion: (String -> Void), error errorHandler: (String -> Void)) -> Request? {
        let stepicURL = NSURL(string: "https://stepic.org/accounts/signup/?next=/")!
        deleteStepicCookiesForSignup()
        //        let d = NSHTTPCookie.requestHeaderFieldsWithCookies((NSHTTPCookieStorage.sharedHTTPCookieStorage().cookiesForURL(stepicURL)!))
        return Alamofire.request(.GET, "https://stepic.org/accounts/signup/?next=/", parameters: nil, encoding: .URL).response {
            (request, response, _, error) -> Void in
            
            if let e = error {
                errorHandler((e as NSError).localizedDescription)
            }
            
            if let r = response {
                let cookies = NSHTTPCookie.cookiesWithResponseHeaderFields(r.allHeaderFields as! [String: String], forURL: stepicURL)
                NSHTTPCookieStorage.sharedHTTPCookieStorage().setCookies(cookies, forURL: stepicURL, mainDocumentURL: nil)
                
                //            for cookie in cookies {
                //                print("Got new cookie with name: \(cookie.name), value: \(cookie.value)\n")
                //            }
                
                for cookie in cookies {
                    if cookie.name == "csrftoken" {
                        completion(cookie.value)
                        return
                    }
                }
                
                errorHandler("No cookie for csrftoken")
            } else {
                errorHandler("No response")
            }
        }
        
    }
    






