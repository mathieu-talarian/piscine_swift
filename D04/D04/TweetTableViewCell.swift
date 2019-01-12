//
//  TweetTableViewCell.swift
//  D04
//
//  Created by Mathieu MOULLEC on 1/12/19.
//  Copyright © 2019 Mathieu MOULLEC. All rights reserved.
//

import UIKit

class TweetTableViewCell: UITableViewCell {

    @IBOutlet weak var Name: UILabel!
    @IBOutlet weak var Date: UILabel!
    
    @IBOutlet var Subject: UITextView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
