//
//  AddViewController.swift
//  D02
//
//  Created by Mathieu MOULLEC on 1/10/19.
//  Copyright © 2019 Mathieu MOULLEC. All rights reserved.
//

import UIKit

class AddViewController: UIViewController {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var nameField: UITextField!
    
    @IBOutlet weak var destField: UITextView!
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var dateField: UIDatePicker!
    override func viewDidLoad() {
        super.viewDidLoad()
        dateField.minimumDate = Date.init()
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
    
    func buildPerson(_ segue: UIStoryboardSegue) {
        if let n = nameField.text, let d = destField.text {
            if n != "" && d != "" {
                let dt = dateField.date
                let person = Person(n, d, dt)
                if let vc = segue.destination as? ViewController {
                    vc.data.newPerson(person)
                }
            } else {
                return
            }
        } else {
            return
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("prepare")
        print(nameField.text!, destField.text!, dateField)
        if let str = segue.identifier {
            switch str {
            case "ReturnHomeSegue":
                self.buildPerson(segue)
                print("return to Home")
            default:
                print("error")
            }
        } else {
            print("errror segue identifier nil")
        }
    }
    
    @IBAction func Save(_ sender: Any) {
        print("saving")
    }
}
