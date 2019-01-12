//
//  APIControllerClass.swift
//  D04
//
//  Created by Mathieu Moullec on 12/01/2019.
//  Copyright © 2019 Mathieu Moullec. All rights reserved.
//

import Foundation

class APIController {
    
    weak var delegate : APITwitterDelegate?
    let token : String
    var tweets: [Tweet] = []
    
    init(delegate: APITwitterDelegate, token: String) {
        self.delegate = delegate
        self.token = token
    }
    
    
    func getTweets(str : String, nbr : Int) {
        print("getFromTwitter(\(str), \(nbr))")
        
        
        
        let query = str.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        let URLRequest = NSMutableURLRequest(url: URL(string : "https://api.twitter.com/1.1/search/tweets.json?q=\(query)&count=\(nbr)&lang=fr&result_type=recent")!)
        
        URLRequest.httpMethod = "GET"
        URLRequest.setValue("Bearer " +  self.token, forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: URLRequest as URLRequest, completionHandler: {
            (data, response, error) in
            if let err = error {
                if let del: APITwitterDelegate = self.delegate {
                    del.printError(err as NSError)
                }
            } else if let d = data {
                do {
                    if let responseObject = try JSONSerialization.jsonObject(with: d, options: []) as? [String:AnyObject],
                        let arrayStatuses = responseObject["statuses"] as? [[String:AnyObject]] {
                        print("Data items count: \(arrayStatuses.count)")
                        for status in arrayStatuses {
                            let text = status["text"] as! String
                            let user = status["user"]?["name"] as! String
                            if let date = status["created_at"] as? String {
                                let dateFormatter = DateFormatter()
                                dateFormatter.dateFormat = "E MMM dd HH:mm:ss Z yyyy"
                                if let date = dateFormatter.date(from: date) {
                                    dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
                                    let newDate = dateFormatter.string(from: date)
                                    self.tweets.append(Tweet(name: user, text: text, date: newDate))
                                }
                            }
                        }
                    }
                    if let del: APITwitterDelegate = self.delegate {
                        del.readTweets(self.tweets)
                    }
                } catch _{
                    print("Connexion lost")
                }
            }
        })
        task.resume()
    }
}
