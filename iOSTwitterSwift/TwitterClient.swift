//
//  TwitterClient.swift
//  iOSTwitterSwift
//
//  Created by Alex on 7/26/14.
//  Copyright (c) 2014 alexnj. All rights reserved.
//

import Foundation

class TwitterClient: BDBOAuth1RequestOperationManager  {
    
    // Singleton sharedInstance implementation.
    // Using struct here since classes don't support static variables,
    // but structs do.
    class var sharedInstance : TwitterClient {
        struct Static {
            static let instance : TwitterClient = TwitterClient()
        }
        return Static.instance
    }

    init() {
        let apiUrl: NSURL = NSURL(string: "https://api.twitter.com/1.1/");
        super.init(baseURL: apiUrl, consumerKey: consumerKey, consumerSecret: consumerSecret);
    }
    
    func isAuthorized() -> Bool {
        return super.authorized
    }
    
    func authorize() {
        let callbackUrl: NSURL = NSURL(string: "iostwitterapp://request")
        
        super.fetchRequestTokenWithPath(
            "/oauth/request_token", method: "POST", callbackURL: callbackUrl, scope: nil, success: { (requestToken: BDBOAuthToken!) -> Void in

                let authUrl = "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)"
                UIApplication.sharedApplication().openURL(NSURL.URLWithString(authUrl));
                
            }, failure: { (requestToken:NSError!) -> Void in
                NSLog("Failed to get request token \(requestToken)")
            }
        )
    }

    func handleOAuthCallback(queryString: NSString, onSuccess: (()->Void)!) {
        let parameters: NSDictionary = NSDictionary(fromQueryString: queryString)

        // Cast to AnyObject? that would help evaluate a nil situation.
        if (parameters[BDBOAuth1OAuthTokenParameter] as AnyObject? &&
            parameters[BDBOAuth1OAuthVerifierParameter] as AnyObject? ) {
            super.fetchAccessTokenWithPath("/oauth/access_token", method: "POST", requestToken: BDBOAuthToken(queryString: queryString), success: {(token: BDBOAuthToken!) -> Void in
                    NSLog("Got oAuth callback Token: \(token)")
                
                    if (onSuccess) {
                        onSuccess();
                    }
                }, failure: { (error: NSError!) -> Void in
                    NSLog("Failed to get oAuth callback. Error: \(error)")
                }
            );
        }
    }
    
    // MARK: APIs
    
    func getTimeline(count: Int, success: ((operation: AFHTTPRequestOperation, object: AnyObject)->Void), failure: ((operation: AFHTTPRequestOperation, err: NSError)->Void)) {
        
        self.GET("statuses/home_timeline.json?count=100", parameters: nil,
            success: {
                (operation: AFHTTPRequestOperation!, responseObject: AnyObject!) -> Void in

                success(operation: operation, object: responseObject)
                
            }, failure: {
                (operation: AFHTTPRequestOperation!, err: NSError!) -> Void in
                
                failure(operation: operation, err: err);
            }
        )
    }
}