//
//  MessagesViewController.swift
//  Rush00
//
//  Created by Mathieu MOULLEC on 1/13/19.
//  Copyright © 2019 Mathieu MOULLEC. All rights reserved.
//

import UIKit

class MessagesViewController: UIViewController, Api42Delegate, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var TableView: UITableView!
    var Messages : [Message] = []
    
    var ApiController: APIController? {
        didSet {
            if let a = self.ApiController {
                a.setDelegate(delegate: self)
            }
        }
    }
    
    var url: URL? {
        didSet {
            if let s = url, let a = self.ApiController {
                a.getMessages(url: s)
            }
        }
    }
    
    override func viewDidLoad() {
        ApiController = nil
        TableView.delegate = self
        TableView.dataSource = self
        url = nil
        Messages.removeAll()
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func read(topics: [Topic]) {
        
    }
    
    func read(messages: [Message]) {
        print("Reading messages")
        self.Messages = messages
        DispatchQueue.main.async {
            self.TableView.reloadData()
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.Messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(self.Messages.count)
        var cellRet : UITableViewCell?
        if let cell = tableView.dequeueReusableCell(withIdentifier: "MessageTableViewCell", for: indexPath) as? MessageTableViewCell {
            cell.Author.text = self.Messages[indexPath.row].author
            if let repliesCount =  self.Messages[indexPath.row].replies {
                cell.RepliesCount.text = repliesCount.count.description
            } else {
                cell.RepliesCount.text = 0.description
            }
            cell.Content.text = self.Messages[indexPath.row].content
            cell.CreatedAt.text = self.Messages[indexPath.row].createdAt
            cell.UpdatedAt.text = self.Messages[indexPath.row].updatedAt
            cell.Message = self.Messages[indexPath.row]
            cell.layer.borderWidth = 1
            cell.layer.borderColor = UIColor.black.cgColor
            cellRet = cell
        }
        return cellRet!
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "repliesSegue" {
            if let cell = sender as? MessageTableViewCell {
                if let c = cell.Message?.replies?.count {
                    if c != 0 {return true}
                }
            }
        }
        return false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "repliesSegue" {
            if let cell = sender as? MessageTableViewCell, let vc = segue.destination as? RepliesViewController {
                vc.datas = cell.Message?.replies
            }
        }
    }
    
}
