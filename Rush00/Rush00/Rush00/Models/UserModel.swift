//
//  UserModel.swift
//  Rush00
//
//  Created by Daniel HADLEY on 1/13/19.
//  Copyright © 2019 Mathieu MOULLEC. All rights reserved.
//

import Foundation


protocol UserDelegate:class {
    func updateUser(user: User?)
}

struct User {
    let name: String
    let id: Int
}
