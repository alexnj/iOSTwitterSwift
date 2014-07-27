//
//  TweetListViewController.swift
//  iOSTwitterSwift
//
//  Created by Alex on 7/26/14.
//  Copyright (c) 2014 alexnj. All rights reserved.
//

import UIKit

class TweetListViewController: UIViewController {

    init() {
        super.init(nibName: nil, bundle: nil)
        
        self.loadTweets()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Implementation of tweet list.
    
    func loadTweets() {
        TwitterClient.sharedInstance.getTimeline(20,
            success: {
                (operation: AFHTTPRequestOperation, object: AnyObject) -> Void in
                
                NSLog("Success \(object)")
            },
            failure: {
                (operation: AFHTTPRequestOperation, err: NSError) -> Void in
                
                NSLog("Failure \(err)")
            }
        );
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
