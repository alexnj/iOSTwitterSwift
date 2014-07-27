//
//  Tweet.swift
//  iOSTwitterSwift
//
//  Created by Alex on 7/26/14.
//  Copyright (c) 2014 alexnj. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    var text: String = ""
    var url: NSURL?
    var dateTweeted: NSDate?
    var userName: String = ""
    var userScreenName: String = ""
    var userProfileImageUrl: String = ""
    
    // This should ideally be static. However, Swift doesn't support static
    // class functions yet. And it's just plain stupid to work it around with
    // a struct.
    func getDateFormatterObject() -> NSDateFormatter {
        let dateFormatter: NSDateFormatter = NSDateFormatter();
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX");
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'";
        
        return dateFormatter;
    }
    
}
