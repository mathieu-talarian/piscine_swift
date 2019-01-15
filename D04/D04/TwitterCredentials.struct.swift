//
//  TwitterCredentials.struct.swift
//  D04
//
//  Created by Mathieu MOULLEC on 1/12/19.
//  Copyright © 2019 Mathieu MOULLEC. All rights reserved.
//

import Foundation

struct TwitterCredentials {
    var ApiKey: String = "xxx"
    var ApiSecretKey: String = "xxx"
    
    var bearer : String {
        return (self.ApiKey + ":" + self.ApiSecretKey)
    }
}
