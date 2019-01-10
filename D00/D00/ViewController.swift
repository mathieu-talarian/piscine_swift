//
//  ViewController.swift
//  D00
//
//  Created by Mathieu MOULLEC on 1/8/19.
//  Copyright © 2019 Mathieu MOULLEC. All rights reserved.
//

import UIKit

enum Operator: String {
    case addition = "+"
    case soustraction = "-"
    case division = "÷"
    case multiplication = "x"
    case none = "n"
    static let allOperators: [Operator] = [addition, soustraction, division, multiplication]
}


class Number {
    
    var leftHand :String
    var rightHand: String
    var op : Operator
    init() {
        leftHand = "0"
        rightHand = "0"
        op = .none
    }
    
    func save(left: String, op: Operator) {
        self.leftHand = left
        self.op = op
    }
    
    func reinit() {
        leftHand = "0"
        op = .none
    }
    
    func exe(right: String) -> String {
        var ret: Int = 0
        self.rightHand = right
        if let l = Int(leftHand), let r = Int(rightHand) {
            switch self.op {
            case .addition:
                ret = r &+ l
            case .division:
                ret = {return r == 0 ? (r) : (l / r)}()
            case .multiplication:
                ret = l &* r
            case .soustraction:
                ret =  l &- r
            case .none:
                ret = 0
            }
        }
        op = .none
        leftHand = String(ret)
        rightHand = "0"
        return leftHand
    }
    
}

extension UILabel {
    static func +(left: UILabel, right: String) -> UILabel{
        if left.text == "0" {
            left.text = right
        } else {
            left.text = left.text! + right
        }
        return left
    }
    
    
    static prefix func !(left: UILabel) -> Bool {
        return left.text != "0"
    }
    
    static prefix func --(left: UILabel) {
        if (left.text!.first != "-")  {
            left.text! = "-" + left.text!
        } else {
            left.text!.removeFirst()
        }
    }
}

class ViewController: UIViewController {
    
    var color : UIColor?
    var numbers = Number()
    @IBOutlet  var divBtn: UIButton!
    @IBOutlet  var multBtn: UIButton!
    @IBOutlet  var ssBtn: UIButton!
    @IBOutlet  var addBtn: UIButton!
    
    @IBOutlet var ans: UILabel!
    var op : Operator?
    @IBOutlet var number: UILabel!
    
    @IBAction func neg(_ sender: Any) {
        --self.number
    }
    
    @IBAction func reset(_ sender: Any) {
        self.resetColors()
        self.number.text = "0"
        self.ans.text = ""
        self.numbers.reinit()
    }
    
    @IBAction func operation(_ sender: UIButton) {
        guard !self.number else {
            return
        }
        if let operand : String = sender.currentTitle {
            for ops in Operator.allOperators {
                if operand == ops.rawValue {
                    self.op = ops
                }
            }
            self.resetColors()
            self.changeColor(sender)
            numbers.save(left: number.text!, op: self.op!)
            ans.text! =  number.text! + " " +  self.op!.rawValue
            number.text = "0"
        }
    }
    
    var reup: Bool = false
    @IBAction func result(_ sender: UIButton) {
        self.resetColors()
        self.number.text = numbers.exe(right: self.number.text!)
        self.ans.text! = ""
        self.reup = true
    }
    
    @IBAction func numberPressed(_ sender: UIButton) {
        self.reup ? self.number.text = "0" : ()
        self.reup = false
        if let num : String = sender.currentTitle {
            number = number + num
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.ans.text = ""
        self.color = self.addBtn.backgroundColor
    }
    
    func changeColor (_ sender:UIButton) {
        self.color = sender.backgroundColor != .blue ? sender.backgroundColor : self.color
        sender.backgroundColor = .blue
    }
    
    func resetColors() {
        self.addBtn.backgroundColor = self.color
        self.multBtn.backgroundColor = self.color
        self.ssBtn.backgroundColor = self.color
        self.divBtn.backgroundColor = self.color
    }
}
