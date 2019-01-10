//
//  ViewController.swift
//  D02
//
//  Created by Mathieu MOULLEC on 1/10/19.
//  Copyright © 2019 Mathieu MOULLEC. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var data: Data = Data()
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    override func viewDidLoad() {
        tableView.estimatedRowHeight = 40.0
        tableView.rowHeight = UITableViewAutomaticDimension
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier! as String {
        case "AddViewSegue":
            print("coucouyyy")
        default:
            print("error")
        }
    }
    
    @IBAction func unwindSegue(segue: UIStoryboardSegue) {
        print(self.data.persons)
        print("coucouxx")
        self.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.persons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PersonCell") as! TableViewCell
        cell.person = self.data.persons[indexPath.row]
        return cell
    }
    
}

