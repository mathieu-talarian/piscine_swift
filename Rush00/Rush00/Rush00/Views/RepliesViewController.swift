//
//  RepliesViewController.swift
//  Rush00
//
//  Created by Mathieu MOULLEC on 1/13/19.
//  Copyright © 2019 Mathieu MOULLEC. All rights reserved.
//

import UIKit

class RepliesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {
    
    
    @IBOutlet var TableView: UITableView!
    
    var Messages: [Message] = []
    
    var datas: [[String:Any]]? {
        didSet {
            self.proceedMessage()
        }
    }
    
    func proceedMessage() {
        if let object = self.datas {
            for d in object {
                let content = d["content"] as! String
                if let user = d["author"] as? [String:AnyObject], let created_date = self.formatDate(mydate: d["created_at"] as! String?), let updated_date = self.formatDate(mydate: d["updated_at"] as! String?) {
                    self.Messages.append(Message(author: user["login"] as! String, content: content, createdAt: created_date, updatedAt: updated_date, replies: nil))
                }
            }
        }
    }
    
    func formatDate(mydate: String?) -> String? {
        if let date1 = mydate {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
            if let date2 = dateFormatter.date(from: date1) {
                print(date2)
                dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
                return dateFormatter.string(from: date2)
            }
        }
        return nil
    }
    

    
    
    override func viewDidLoad() {
        TableView.delegate = self
        TableView.dataSource = self
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        return self.Messages.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(self.Messages.count)
        var cellRet : UITableViewCell?
        if let cell = tableView.dequeueReusableCell(withIdentifier: "MessageTableViewCell", for: indexPath) as? MessageTableViewCell {
            cell.Author.text = self.Messages[indexPath.row].author
            cell.Content.text = self.Messages[indexPath.row].content
            cell.CreatedAt.text = self.Messages[indexPath.row].createdAt
            cell.UpdatedAt.text = self.Messages[indexPath.row].updatedAt
            cell.Message = self.Messages[indexPath.row]
            cell.RepliesCount.text = ""
            cellRet = cell
        }
        return cellRet!
    }
}
