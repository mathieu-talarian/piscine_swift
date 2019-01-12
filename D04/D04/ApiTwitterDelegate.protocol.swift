//
//  ApiTwitterDelegate.swift
//  D04
//
//  Created by Mathieu MOULLEC on 1/12/19.
//  Copyright © 2019 Mathieu MOULLEC. All rights reserved.
//

import Foundation

protocol ApiTwitterDelegate: class {
    func readTweets(tweets: [Tweet])
    func printError(error: NSError)
}
