//
//  MessageTableViewCell.swift
//  Rush00
//
//  Created by Mathieu MOULLEC on 1/13/19.
//  Copyright © 2019 Mathieu MOULLEC. All rights reserved.
//

import UIKit

class MessageTableViewCell: UITableViewCell {
    
    
    var Message: Message?
    
    @IBOutlet var Author: UILabel!
    
    @IBOutlet var RepliesCount: UILabel!
    
    
    @IBOutlet var Content: UILabel!
    @IBOutlet var CreatedAt: UILabel!
    @IBOutlet var UpdatedAt: UILabel!
    
    override func awakeFromNib() {
        
        RepliesCount.text = ""
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
