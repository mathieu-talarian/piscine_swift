//: Playground - noun: a place where people can play

import UIKit

func getTopics () {
    let URLRequest = NSMutableURLRequest(url: URL(string: "https://api.intra.42.fr/v2/topics")!)
    URLRequest.httpMethod = "GET"
    URLRequest.setValue("Bearer ace41ead28762688dce4138e0398fd82c3083da1b0600aa53ea83df421ebbd38", forHTTPHeaderField: "Authorization")
    let task = URLSession.shared.dataTask(with: URLRequest as URLRequest, completionHandler: {
        (data, response, error) in
        if let err = error {
            print(err)
        } else if let d = data {
            print("data", d.description)
            do {
                if let responseObject = try JSONSerialization.jsonObject(with: d, options: []) as? [String:AnyObject] {
                    print("here", responseObject)
                    //                        for status in arrayStatuses {
                    //                            let text = status["text"] as! String
                    //                            let user = status["user"]?["name"] as! String
                    //                            if let date = status["created_at"] as? String {
                    //                                let dateFormatter = DateFormatter()
                    //                                dateFormatter.dateFormat = "E MMM dd HH:mm:ss Z yyyy"
                    //                                if let date = dateFormatter.date(from: date) {
                    //                                    dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
                    //                                    let newDate = dateFormatter.string(from: date)
                    //                                    self.tweets.append(Tweet(name: user, text: text, date: newDate))
                    //                                }
                    //                            }
                    //                        }
                }
//                if let del: Api42Delegate = self.delegate {
//                    del.readTopics(topics: self.Topics)
//                }
            } catch _{
                print("Connexion lost")
            }
        }
    })
    task.resume()
}

getTopics()
