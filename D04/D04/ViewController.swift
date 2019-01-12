//
//  ViewController.swift
//  D04
//
//  Created by Mathieu MOULLEC on 1/12/19.
//  Copyright © 2019 Mathieu MOULLEC. All rights reserved.
//

import UIKit

class ViewController: UIViewController, ApiTwitterDelegate , UITableViewDataSource, UITableViewDelegate  {
    
    
    var token : String?
    var apiController : APIController?
    var tweets : [Tweet] = []
    var credential : TwitterCredentials = TwitterCredentials()
    var searchString:String = "ecole 42"

    
    @IBOutlet var searchField: UITextField!
    @IBAction func seachFieldChanger(_ textField: UITextField) {
        textField.resignFirstResponder()
        if let s = textField.text {
            searchString = s
            self.tweets = []
            initToken()
        }
    }
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        searchField.placeholder = searchString
        //         Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 140
        initToken()
    }
    
    func initToken() {
        let bearer_credentials = (credential.bearer.data(using: String.Encoding.utf8))?.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
        let url = URL(string: "https://api.twitter.com/oauth2/token")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.setValue("Basic " + bearer_credentials!, forHTTPHeaderField: "Authorization")
        request.setValue("application/x-www-form-urlencoded;charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.httpBody = "grant_type=client_credentials".data(using: String.Encoding.utf8)
        let task = URLSession.shared.dataTask(with: request as URLRequest) { data, response, error in
            guard let data = data, error == nil else {
                print(error!)
                return
            }
            do {
                if let dic: NSDictionary = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                    print(dic)
                    self.token = (dic["access_token"] as? String)!
                    self.apiController = APIController(delegate: self, token: self.token!)
                    self.apiController?.getTweets(str: self.searchString, nbr: 100)
                }
            }
            catch (let err) {
                print(err)
            }
        }
        task.resume()
    }
    
    
    func readTweets(tweets : [Tweet]) {
        self.tweets = tweets
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
    }
    
    func printError(error : NSError) {
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1 // nous n'avons qu'une seule section
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cellRet : UITableViewCell?
        if let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCellId", for: indexPath) as? TweetTableViewCell {
            cell.Name.text = self.tweets[indexPath.row].name
            cell.Date.text = self.tweets[indexPath.row].date
            print(self.tweets[indexPath.row].text)
            cell.Subject.text = self.tweets[indexPath.row].text
            cellRet = cell
        }
        return cellRet!
    }
    
}
