//
//  TwitterCredentials.struct.swift
//  D04
//
//  Created by Mathieu MOULLEC on 1/12/19.
//  Copyright © 2019 Mathieu MOULLEC. All rights reserved.
//

import Foundation

struct TwitterCredentials {
    var ApiKey: String = "Wf8FKvQnQyze9CNxIiDGrXqzJ"
    var ApiSecretKey: String = "XBESsJlt5CRloZ7dePC2bgxeUOiJPjuoUn37fir73ZS3NL3X5a"
    
    var bearer : String {
        return (self.ApiKey + ":" + self.ApiSecretKey)
    }
}
