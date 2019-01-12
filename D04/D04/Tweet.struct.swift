//
//  TweetStruct.swift
//  D04
//
//  Created by Mathieu MOULLEC on 1/12/19.
//  Copyright © 2019 Mathieu MOULLEC. All rights reserved.
//

import Foundation

struct Tweet: CustomStringConvertible {
    var description: String {
        return "\(self.name) \(self.text)"
    }
    
    var name : String
    var text : String
    var date : String
}
