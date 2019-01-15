import UIKit
import Foundation


var Token : String = "a8340e606f6641b92b2784cb6f8f9d5093cfa8c0e7bc9f75032c68506853fbd3"

//func getPosts(url: URL) {
////    let query = url.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
//    let URLRequest = NSMutableURLRequest(url: url)
//
//    URLRequest.httpMethod = "GET"
//    URLRequest.setValue("Bearer " +  Token, forHTTPHeaderField: "Authorization")
//
//    let task = URLSession.shared.dataTask(with: URLRequest as URLRequest, completionHandler: {
//        (data, response, error) in
//        if let err = error {
//            print(err)
////            if let del: ApiTwitterDelegate = self.delegate {
////                del.printError(error: err as NSError)
////            }
//        } else if let d = data {
//            do {
//                if let responseObject = try JSONSerialization.jsonObject(with: d, options: []) as? [String:AnyObject],
//                    let arrayStatuses = responseObject["statuses"] as? [[String:AnyObject]] {
//                    print("Data items count: \(arrayStatuses.count)")
////                    for status in arrayStatuses {
////                        let text = status["text"] as! String
////                        let user = status["user"]?["name"] as! String
////                        if let date = status["created_at"] as? String {
////                            let dateFormatter = DateFormatter()
////                            dateFormatter.dateFormat = "E MMM dd HH:mm:ss Z yyyy"
////                            if let date = dateFormatter.date(from: date) {
////                                dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
////                                let newDate = dateFormatter.string(from: date)
////                                self.tweets.append(Tweet(name: user, text: text, date: newDate))
////                            }
////                        }
////                    }
//                }
////                if let del: ApiTwitterDelegate = self.delegate {
////                    del.readTweets(tweets: self.tweets)
////                }
//            } catch _{
//                //                    print("Connexion lost")
//            }
//        }
//    })
//    task.resume()
//
//}

func getPosts(url: URL) {
    print(url.description)
}
getPosts(url: URL(string: "https://api.intra.42.fr/v2/cursus_topics")!)
