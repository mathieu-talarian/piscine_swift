//
//  UserController.swift
//  Rush00
//
//  Created by Daniel HADLEY on 1/13/19.
//  Copyright © 2019 Mathieu MOULLEC. All rights reserved.
//

import Foundation

class UserController {
    
    weak var delegate: UserDelegate?
    var token: String?
    
    init(delegate: UserDelegate, token: String?) {
        self.delegate = delegate
        self.token = token
    }
    
    
    func createUrlRequest () ->NSMutableURLRequest {
        let URLRequest = NSMutableURLRequest(url: URL(string: "https://api.intra.42.fr/v2/me")!)
        URLRequest.httpMethod = "GET"
        URLRequest.setValue("Bearer " + self.token!, forHTTPHeaderField: "Authorization")
        return URLRequest
    }
    
    func getUser () {
        let URLRequest = self.createUrlRequest()
        print("The url is \(URLRequest)")
        let task = URLSession.shared.dataTask(with: URLRequest as URLRequest, completionHandler: {
            (data, response, error) in
            if let err = error {
                print(err)
            } else if let d = data {
                print("data", d.description)
                do {
                    if let responseObject = try JSONSerialization.jsonObject(with: d, options: []) as? [String:AnyObject] {
                        let username = responseObject["login"] as? String
                        print("The username is \(String(describing: username))")
                        let userId = responseObject["id"] as? Int
                        print("And the id is \(String(describing: userId))")
                        let user = User(name: username!, id: userId!)
                        DispatchQueue.main.async {
                            if let userDelegate: UserDelegate = self.delegate {
                                userDelegate.updateUser(user: user)
                            }
                        }
                    }
                } catch _{
                    print("Connexion lost")
                }
            }
        })
        task.resume()
    }
    
}
