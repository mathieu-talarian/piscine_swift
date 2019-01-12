//
//  TweetStruct.swift
//  D04
//
//  Created by Mathieu Moullec on 12/01/2019.
//  Copyright © 2019 Mathieu Moullec. All rights reserved.
//

import Foundation

struct Tweet  {
    let name : String
    let text : String
    let date : String
    var description: String {
        return "(\(name) : \(text)\n \(date))"
    }
}
