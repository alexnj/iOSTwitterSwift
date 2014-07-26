//
//  TwitterClient.swift
//  iOSTwitterSwift
//
//  Created by Alex on 7/26/14.
//  Copyright (c) 2014 alexnj. All rights reserved.
//

import Foundation

class TwitterClient: BDBOAuth1RequestOperationManager {
    
    // Singleton sharedInstance implementation.
    // Using struct here since classes don't support static variables,
    // but structs do.
    class var sharedInstance : TwitterClient {
        struct Static {
            static let instance : TwitterClient = TwitterClient()
        }
        return Static.instance
    }
    
}