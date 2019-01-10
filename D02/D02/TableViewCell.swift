//
//  TableViewCell.swift
//  D02
//
//  Created by Mathieu MOULLEC on 1/10/19.
//  Copyright © 2019 Mathieu MOULLEC. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var date: UILabel!
    var person: Person? {
        didSet {
            if let p = person {
                self.title?.text = p.name
                self.desc?.text = p.desc
                self.date?.text = p.date.description
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
