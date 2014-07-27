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
    var createdAt: NSDate?
    var user: User

    init() {
        self.user = User()
    }
    
    func getTimeElapsedSinceCreatedAt() -> String {
        let interval = Float(self.createdAt!.timeIntervalSinceNow)
        let second: Float = 1.0, minute: Float = second*60, hour: Float = minute*60, day: Float = hour*24
        var num: Float = abs(interval),
            beforeOrAfter = "before",
            unit = "day",
            retVal = "now";
        
        if (interval == 0) {
            return retVal
        }
        
        if (interval > 0) {
            beforeOrAfter = "after"
        }
        
        if (num >= day) {
            num /= day;
            if (num > 1) {
                unit = "d"
            }
        }
        else if (num >= hour) {
            num /= hour;
            unit = "h"
        }
        else if (num >= minute) {
            num /= minute;
            unit = "m";
        }
        else if (num >= second) {
            num /= second;
            unit = "s";
        }
        
        return "\(Int(num))\(unit)"
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
        tweet.createdAt = formatter.dateFromString(dictTweet["created_at"] as String)
        
        tweet.user = User.fromDictionary(dictTweet["user"] as NSDictionary);

        return tweet;
    }
}
