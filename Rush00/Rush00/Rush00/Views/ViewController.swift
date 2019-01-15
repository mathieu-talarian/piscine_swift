//
//  ViewController.swift
//  Rush00
//
//  Created by Mathieu MOULLEC on 1/12/19.
//  Copyright © 2019 Mathieu MOULLEC. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, oauthDelegate, UserDelegate {
    
    var token: String?
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        URLCache.shared.removeAllCachedResponses()
//        if let cookies = HTTPCookieStorage.shared.cookies {
//            for cookie in cookies {
//                HTTPCookieStorage.shared.deleteCookie(cookie)
//            }
//        }
        clearCache()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func clearCache() {
        HTTPCookieStorage.shared.removeCookies(since: Date.distantPast)
        WKWebsiteDataStore.default().fetchDataRecords(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes()) { records in
            records.forEach { record in
                WKWebsiteDataStore.default().removeData(ofTypes: record.dataTypes, for: [record], completionHandler: {})
                print("[WebCacheCleaner] Record \(record) deleted")
            }
        }
    }
    
    func authorisation(success: Bool, token: String?) {
        if success {
            self.token = token
            let userController = UserController(delegate: self, token: token)
            userController.getUser()
        } else {
            clearCache()
            // TODO: Show error because user denied authorisation
        }
    }
    
    func updateUser(user: User?) {
        if (user != nil) {
            self.user = user
            self.performSegue(withIdentifier: "topicsSegue", sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "oauthSegue") {
            print("Login pressed and going to oauth View Controller")
            let oauthViewController = segue.destination as! AuthorizationViewController
            oauthViewController.delegate = self
        } else if (segue.identifier == "topicsSegue") {
            print("\n\nBACK IN MAIN VC AND ABOUT TO PERFORM TOPICS SEGUE")
            let topicsViewController = segue.destination as! TopicsViewController
            topicsViewController.accessToken = self.token
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
