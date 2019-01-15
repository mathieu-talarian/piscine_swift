//
//  APIController.swift
//  Rush00
//
//  Created by Daniel HADLEY on 1/13/19.
//  Copyright © 2019 Mathieu MOULLEC. All rights reserved.
//

import Foundation

class APIController {
    weak var delegate : Api42Delegate?
    var Token : String?
    var Topics : [Topic] = []
    var Messages : [Message] = []
    
    init(delegate: Api42Delegate, token: String) {
        self.delegate = delegate
        self.Token = token
    }
    
    func setDelegate(delegate: Api42Delegate){
        self.delegate = delegate
    }
    
    func createUrlRequest () ->NSMutableURLRequest {
        let URLRequest = NSMutableURLRequest(url: URL(string: "https://api.intra.42.fr/v2/topics")!)
        URLRequest.httpMethod = "GET"
        URLRequest.setValue("Bearer " + self.Token!, forHTTPHeaderField: "Authorization")
        return URLRequest
    }
    
    func createUrlRequest(url: URL) ->NSMutableURLRequest {
        let URLRequest =    NSMutableURLRequest(url: url)
        URLRequest.httpMethod = "GET"
        URLRequest.setValue("Bearer " + self.Token!, forHTTPHeaderField: "Authorization")
        return URLRequest
    }
    
    func getTopics () {
        Topics.removeAll()
        let URLRequest = self.createUrlRequest()
        let task = URLSession.shared.dataTask(with: URLRequest as URLRequest, completionHandler: {
            (data, response, error) in
            if let err = error {
                print(err)
            } else if let d = data {
                print("data", d.description)
                do {
                    if let responseObject = try JSONSerialization.jsonObject(with: d, options: []) as? [[String:AnyObject]] {
                        for object in responseObject {
                            let name = object["name"] as! String
                            let messages_url = object["messages_url"] as! String
                            if let user = object["author"], let created_date = self.formatDate(mydate: object["created_at"] as! String?), let updated_date = self.formatDate(mydate: object["updated_at"] as! String?) {
                                self.Topics.append(Topic(name: name, author: user["login"] as! String, createdAt: created_date, updatedAt: updated_date, messageUrl: URL(string: messages_url)!))
                            }
                        }
                    }
                    if let del: Api42Delegate = self.delegate {
                        del.read(topics: self.Topics)
                    }
                } catch _{
                    print("Connexion lost")
                }
            }
        })
        task.resume()
    }
    
    func getMessages (url: URL) {
        Messages.removeAll()
        print("GetMessages")
        let URLRequest = self.createUrlRequest(url: url)
        let task = URLSession.shared.dataTask(with: URLRequest as URLRequest, completionHandler: {
            (data, response, error) in
            if let err = error {
                print(err)
            } else if let d = data {
                print("data", d.description)
                do {
                    if let responseObject = try JSONSerialization.jsonObject(with: d, options: []) as? [[String:AnyObject]] {
                        for object in responseObject {
                            let content = object["content"] as! String
                            let messages_repiles = object["replies"] as? [[String:AnyObject]]
                            print(messages_repiles)
                            if let user = object["author"], let created_date = self.formatDate(mydate: object["created_at"] as! String?), let updated_date = self.formatDate(mydate: object["updated_at"] as! String?) {
                                self.Messages.append(Message(author: user["login"] as! String, content: content, createdAt: created_date, updatedAt: updated_date, replies: messages_repiles))
                            }
                        }
                    }
                    if let del: Api42Delegate = self.delegate {
                        del.read(messages: self.Messages)
                    }
                } catch _{
                    print("Connexion lost")
                }
            }
        })
        task.resume()
    }
    
    func formatDate(mydate: String?) -> String? {
        if let date1 = mydate {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
            if let date2 = dateFormatter.date(from: date1) {
                dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
                return dateFormatter.string(from: date2)
            }
        }
        return nil
    }
    
    func topicDeserialisation(_ data: Data) {
        do {
            if let dic : NSDictionary = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                print(dic)
            }
        }
        catch( let err) {
            print(err)
        }
    }
}
