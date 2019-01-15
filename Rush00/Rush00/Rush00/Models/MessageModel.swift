//
//  MessageModel.swift
//  Rush00
//
//  Created by Mathieu MOULLEC on 1/13/19.
//  Copyright © 2019 Mathieu MOULLEC. All rights reserved.
//

import Foundation

struct Message: CustomStringConvertible {
    var author : String
    var content: String
    var createdAt: String
    var updatedAt: String
    var replies: [[String:AnyObject]]?
    
    var description: String {
        return "\(content), written by \(author) the \(createdAt)"
    }
}
