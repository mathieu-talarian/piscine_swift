//
//  APITwitterDelegateProtocol.swift
//  D04
//
//  Created by Mathieu Moullec on 12/01/2019.
//  Copyright © 2019 Mathieu Moullec. All rights reserved.
//

import Foundation

protocol APITwitterDelegate : class { // le mot cle class permet d'imposer que ce protocol ne soit utilise que par des classes
    func readTweets(_ tweets : [Tweet])
    func printError(_ error : NSError)
}
