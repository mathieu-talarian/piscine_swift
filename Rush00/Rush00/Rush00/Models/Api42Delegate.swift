//
//  Api42Delegate.swift
//  Rush00
//
//  Created by Mathieu MOULLEC on 1/13/19.
//  Copyright © 2019 Mathieu MOULLEC. All rights reserved.
//

import Foundation

protocol Api42Delegate: class {
    func read(topics: [Topic])
    func read(messages: [Message])
}
