//
//  TopicsViewController.swift
//  Rush00
//
//  Created by Daniel HADLEY on 1/13/19.
//  Copyright © 2019 Mathieu MOULLEC. All rights reserved.
//

import UIKit

class TopicsViewController: UIViewController, Api42Delegate, UITableViewDataSource, UITableViewDelegate {

    var accessToken: String?
    var Topics: [Topic] = []
    var apiController : APIController?

    @IBOutlet var TableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TableView.delegate = self
        TableView.dataSource = self
        TableView.estimatedRowHeight = 200
        TableView.rowHeight = UITableViewAutomaticDimension
        self.apiController = APIController(delegate: self, token: accessToken!)
        self.apiController?.getTopics()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func read(topics: [Topic]) {
        self.Topics = topics
        DispatchQueue.main.async {
            self.TableView.reloadData()
        }
    }
    
    func read(messages: [Message]) {
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.Topics.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cellRet : UITableViewCell?
        if let cell = tableView.dequeueReusableCell(withIdentifier: "TopicsTabViewCellId", for: indexPath) as? TopicsTableViewCell {
            let subject = Topics[indexPath.row].name
            let author = Topics[indexPath.row].author
            let createdAt = Topics[indexPath.row].createdAt
            let updatedAt = Topics[indexPath.row].updatedAt
            
            cell.Subject.text = subject
            cell.Author.text = "By: "
            cell.Author.text?.append(author)
            cell.updated_at.text = "Last updated: "
            cell.updated_at.text?.append(updatedAt)
            cell.created_at.text = "Created: "
            cell.created_at.text?.append(createdAt)
            cell.messageUrl = Topics[indexPath.row].messageUrl
            cell.layer.borderWidth = 1
            cell.layer.borderColor = UIColor.black.cgColor
            cellRet = cell
        }
        return cellRet!
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "messageSegue" {
            if let cell = sender as? TopicsTableViewCell, let vc = segue.destination as? MessagesViewController {
                vc.ApiController = self.apiController
                vc.url = cell.messageUrl
            }
        }
    }

}
