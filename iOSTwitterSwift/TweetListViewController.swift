//
//  TweetListViewController.swift
//  iOSTwitterSwift
//
//  Created by Alex on 7/26/14.
//  Copyright (c) 2014 alexnj. All rights reserved.
//

import UIKit

class TweetListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    private var tweets: Array<Tweet> = Array<Tweet>()
    private var _prototypeCell: TweetTableViewCell?
    
    private var prototypeCell: TweetTableViewCell {
        if (!self._prototypeCell) {
            self._prototypeCell = self.tweetList.dequeueReusableCellWithIdentifier("TweetTableViewCell") as? TweetTableViewCell
        }
        return self._prototypeCell!
    }

    @IBOutlet var tweetList: UITableView!

    init() {
        super.init(nibName: nil, bundle: nil)
        self.updateTimeline()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        self.tweetList.delegate = self
        self.tweetList.dataSource = self
        
        self.tweetList.rowHeight = 100
        
        let tableViewNib: UINib = UINib(nibName: "TweetTableViewCell", bundle: nil)
        self.tweetList.registerNib(tableViewNib, forCellReuseIdentifier: "TweetTableViewCell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return self.tweets.count
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        let cell: TweetTableViewCell = tableView.dequeueReusableCellWithIdentifier("TweetTableViewCell", forIndexPath: indexPath!) as TweetTableViewCell
        cell.tweet = self.tweets[indexPath.row];
        return cell;
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
    
    
    // MARK: Variable height table cells
    
    // The approach is to have a dummy cell (prototypeCell) to do the calculation
    // when heightForRowAtIndexPath is requested. To make it more efficient and
    // non-sluggish, estimatedHeightForRowAtIndexPath is implemented that returns
    // a fixed estimation for offscreen cells.
    
    func configurePrototypeCell(cell: TweetTableViewCell, indexPath: NSIndexPath) {
        // Configure the given dummy cell to calculate height
        cell.tweet = self.tweets[indexPath.row]
        cell.layoutIfNeeded()
    }
    
    func tableView(tableView: UITableView!, heightForRowAtIndexPath indexPath: NSIndexPath!) -> CGFloat {
        self.configurePrototypeCell(self.prototypeCell, indexPath: indexPath)
        
        // Fix the issue in width calculation on orientation change.
        // Combined with prototypeCell:layoutSubviews, this fixes
        // the issue where text height is wrong for multi-line text
        // (Especially when 3 lines of text, it introduces padding on
        // upper and lower edges).
        
        self.prototypeCell.bounds = CGRectMake(0.0, 0.0, CGRectGetWidth(self.tweetList.bounds), CGRectGetHeight(self.prototypeCell.bounds))
        let size: CGSize = self.prototypeCell.contentView.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize)
        return size.height+1
    }
    
    func tableView(tableView: UITableView!, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath!) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
}
