//
//  TopicModel.swift
//  Rush00
//
//  Created by Daniel HADLEY on 1/13/19.
//  Copyright © 2019 Mathieu MOULLEC. All rights reserved.
//

import Foundation
struct Topic: CustomStringConvertible {
    
    var name: String
    var author : String
    var createdAt: String
    var updatedAt: String
    var messageUrl: URL
    
    var description: String {        
        return "\(name), created by \(author) on \(createdAt), last updated on \(updatedAt)"
    }
}

