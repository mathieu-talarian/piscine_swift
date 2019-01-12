//
//  42ApiCredentials.swift
//  Rush00
//
//  Created by Mathieu MOULLEC on 1/12/19.
//  Copyright © 2019 Mathieu MOULLEC. All rights reserved.
//

import Foundation

struct Credentials {
    var redirectURI: String
    private var uid : String
    private var secret : String
    private var state: String
    init(uid : String, secret: String, rUri : String, state: String) {
        self.uid = uid
        self.secret = secret
        self.redirectURI = rUri
        self.state = state
    }
    
    var URL : String {
        return "https://api.intra.42.fr/oauth/authorize?client_id=\(self.uid)&redirect_uri=\(self.redirectURI)&response_type=code&state=\(self.state)".addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
    }
}

var mmoullec42ApiCredentials: Credentials = Credentials(uid: "4f6d761d538581568d0cab83645f904461be95cf53d9cb74c15b5446e9dfa6e9", secret: "9be73131c157e1d430e8b15a0dac41c900ba36b11d636c4ec61edbde789a86a3", rUri: "com.mmoullec.rush00://authorize", state: "39048def4c280439e1f621e0137c1993e6495a0e")
