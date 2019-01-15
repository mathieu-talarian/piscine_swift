//
//  42ApiCredentials.swift
//  Rush00
//
//  Created by Mathieu MOULLEC on 1/12/19.
//  Copyright © 2019 Mathieu MOULLEC. All rights reserved.
//

import Foundation

struct Credentials {
    private var redirectURI: String
    private var uid : String
    private var secret : String
    
    init(uid : String, secret: String, rUri : String ) {
        self.uid = uid
        self.secret = secret
        self.redirectURI = rUri
    }
    
    var URL : String {
        return "https://api.intra.42.fr/oauth/authorize?client_id=\(self.uid)&redirect_uri=\(self.redirectURI)&response_type=code&scope=public+forum".addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
    }
}

var mmoullec42ApiCredentials: Credentials = Credentials(uid: "4141358e1df37fbee61b4859034d078b31376fa2996d354975bc9b086b60a073", secret: "896b82ef7831e9d4c316e3b570951af89aee3b0f36effc21168ecbb1450ab3c7", rUri: "com.mmoullec.rush00://authorize")
