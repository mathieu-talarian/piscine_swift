//
//  TopicsTableViewCell.swift
//  Rush00
//
//  Created by Daniel HADLEY on 1/13/19.
//  Copyright © 2019 Mathieu MOULLEC. All rights reserved.
//

import UIKit

class TopicsTableViewCell: UITableViewCell {

    
    @IBOutlet var Subject: UILabel!
    @IBOutlet var Author: UILabel!
    @IBOutlet var created_at: UILabel!
    @IBOutlet var updated_at: UILabel!
    
    var messageUrl: URL!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
}
