//
//  User.swift
//  iOSTwitterSwift
//
//  Created by Alex on 7/26/14.
//  Copyright (c) 2014 alexnj. All rights reserved.
//

import Foundation

class User {
    var name: String = ""
    var screenName: String = ""
    var profileImageUrl: String = ""
    
    init() {
        
    }
    
    class func fromDictionary(dictUser: NSDictionary) -> User {
        var user = User()
        
        user.name = dictUser["name"] as String
        user.screenName = dictUser["screen_name"] as String
        user.profileImageUrl = dictUser["profile_image_url"] as String
        
        return user
    }
}
