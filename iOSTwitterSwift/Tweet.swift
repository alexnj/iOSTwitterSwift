//
//  Tweet.swift
//  iOSTwitterSwift
//
//  Created by Alex on 7/26/14.
//  Copyright (c) 2014 alexnj. All rights reserved.
//
import Foundation

class Tweet {
    var text: String = ""
    var url: NSURL?
    var dateTweeted: NSDate?
    var user: User

    init() {
        self.user = User()
    }
    
    func getTimeElapsedSinceCreatedAt() -> String {
        if let dateTweeted: NSDate = self.dateTweeted {
            return Tweet.getDateFormatterObject().stringFromDate(dateTweeted)
        }
        else {
            return "";
        }
    }
    
    class func getDateFormatterObject() -> NSDateFormatter {
        let dateFormatter: NSDateFormatter = NSDateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US")
        dateFormatter.dateFormat = "eee, MMM dd"
        
        return dateFormatter;
    }
    
    class func fromJsonTweet(dictTweet: NSDictionary) -> Tweet {
        var tweet = Tweet();
        
        tweet.text = dictTweet["text"] as String
        if let url: String = dictTweet["url"] as? String {
            tweet.url = NSURL(string: url)
        }
        
        let formatter: NSDateFormatter = NSDateFormatter()
        formatter.dateFormat = "eee, MMM dd HH:mm:ss ZZZZ yyyy"
        tweet.dateTweeted = formatter.dateFromString(dictTweet["created_at"] as String)
        
        tweet.user = User.fromDictionary(dictTweet["user"] as NSDictionary);

        return tweet;
    }
}
