//
//  TweetTableViewCell.swift
//  iOSTwitterSwift
//
//  Created by Alex on 7/27/14.
//  Copyright (c) 2014 alexnj. All rights reserved.
//

import UIKit

class TweetTableViewCell: UITableViewCell {
    @IBOutlet var userProfileImage: UIImageView!
    @IBOutlet var userName: UILabel!
    @IBOutlet var userScreenName: UILabel!
    @IBOutlet var createdAt: UILabel!
    @IBOutlet var tweetText: UILabel!

    private var _tweet: Tweet?

    var tweet: Tweet? {
    get {
        return self._tweet
    }
    set(tweet) {
        self._tweet = tweet
        
        if (tweet) {
            self.userName.text = tweet!.user.name
            self.userScreenName.text = tweet!.user.screenName
            self.tweetText.text = tweet!.text
            self.createdAt.text = tweet!.getTimeElapsedSinceCreatedAt()
        }
    }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
