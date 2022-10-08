//
//  TweetCell.swift
//  Twitter
//
//  Created by rodeo station on 9/27/22.
//  Copyright © 2022 Dan. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {

  
    @IBOutlet var imgHeight: NSLayoutConstraint!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favButton: UIButton!
    @IBOutlet weak var imgView: UIImageView!
    var favorited:Bool=false
    var retweeted:Bool=false
    var tweetId:Int = -1
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func retweet(_ sender: Any) {
        TwitterAPICaller.client?.retweet(tweetId: tweetId, success: {
            self.setRetweeted(true)
        }, failure: { Error in
            print("Retweet did not succeed: \(Error)")
        })
    }
    func setRetweeted(_ isRetweeted:Bool){
        retweeted=isRetweeted
        if(retweeted){
            retweetButton.setImage(UIImage(named:"retweet-icon-green"), for: UIControl.State.normal)
        }else{
            retweetButton.setImage(UIImage(named:"retweet-icon"), for: UIControl.State.normal)
        }
    }

    func setFavorite(_ isFavorited:Bool){
        favorited=isFavorited
        if(favorited){
            favButton.setImage(UIImage(named:"favor-icon-red"), for: UIControl.State.normal)
        }else{
            favButton.setImage(UIImage(named:"favor-icon"), for: UIControl.State.normal)
        }
    }
    @IBAction func favTweet(_ sender: Any) {
        let toBeFavorited = !favorited
        if(toBeFavorited){
            TwitterAPICaller.client?.favoriteTweet(tweetId:tweetId,success:{
                self.setFavorite(true)
            },failure:{(Error) in
                print("Favorite did not succeed: \(Error)")
            })
        }else{
            TwitterAPICaller.client?.unfavoriteTweet(tweetId:tweetId,success:{
                self.setFavorite(false)
            },failure:{(Error) in
                print("Unfavorite did not succeed: \(Error)")
            })
        }
    }
    
    
    
}
