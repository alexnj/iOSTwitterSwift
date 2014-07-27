//
//  TweetListViewController.swift
//  iOSTwitterSwift
//
//  Created by Alex on 7/26/14.
//  Copyright (c) 2014 alexnj. All rights reserved.
//

import UIKit

class TweetListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var tweets: Array<Tweet> = Array<Tweet>()

    @IBOutlet var tweetList: UITableView!

    init() {
        super.init(nibName: nil, bundle: nil)
        self.updateTimeline()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        self.tweetList.delegate = self
        self.tweetList.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return self.tweets.count
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        let v: UITableViewCell = UITableViewCell()
        v.textLabel.text = self.tweets[indexPath.row].text
        return v
    }
    
    func updateTimeline() {
        TwitterClient.sharedInstance.getTimeline(20,
            success: {
                (tweets: Array<Tweet>) -> Void in
                self.tweets = tweets
                self.tweetList.reloadData()
            },
            failure: {
                (operation: AFHTTPRequestOperation, err: NSError) -> Void in
                
                NSLog("Failure \(err)")
            }
        );
    }
}
