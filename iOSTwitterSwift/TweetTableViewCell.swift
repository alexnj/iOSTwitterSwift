//
//  TweetTableViewCell.swift
//  iOSTwitterSwift
//
//  Created by Alex on 7/27/14.
//  Copyright (c) 2014 alexnj. All rights reserved.
//

import UIKit
import QuartzCore;

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
            
            // Set image.
            NSURLConnection.sendAsynchronousRequest(
                NSURLRequest(URL: NSURL(string: tweet!.user.profileImageUrl)),
                queue: NSOperationQueue.mainQueue(),
                completionHandler: {
                    (response: NSURLResponse!, data: NSData!, err: NSError!) -> Void in
                    let image = UIImage(data: data)
                    self.setImageOnMainThread(self.userProfileImage, image:image)
                }
            )
            
        }
    }
    }
    
    func setImageOnMainThread(imageView: UIImageView, image: UIImage?) {
        if (!image) {
            return;
        }
        
        dispatch_async(dispatch_get_main_queue(),
            { ()->Void in
                let t = CATransition()
                t.type = kCATransitionFade
                t.duration = 0.5
                t.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
                imageView.layer.addAnimation(t, forKey: nil)
                
                imageView.image = image
            }
        );
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
