//
//  ProfileViewController.swift
//  Twitter
//
//  Created by rodeo station on 10/6/22.
//  Copyright © 2022 Dan. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    var tweetId:String = ""
    var userObject=NSDictionary()
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screenLabel: UILabel!
    
    @IBOutlet weak var bannerView: UIImageView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var bioLabel: UILabel!
    @IBOutlet weak var tweetsLabel: UILabel!
    
    @IBOutlet weak var followersLabel: UILabel!
    @IBOutlet weak var followingLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.layer.cornerRadius=imageView.frame.size.width/2
        imageView.layer.masksToBounds=true
        imageView.layer.borderWidth=5.0
        imageView.layer.borderColor=UIColor.white.cgColor
        
        getId()
        //print(tweetId)
        /*
        if(tweetId != ""){
            print("test")
            displayProfile()
        }*/
        
    }
    
  
    
    
    @objc func getId(){
        let url="https://api.twitter.com/2/users/me"
        TwitterAPICaller.client?.getDictionaryNoParameters(url: url, parameters: nil, success: { (me:NSDictionary) in
            let data=me["data"] as! NSDictionary
            self.tweetId=data["id"] as! String
            
            self.displayProfile()
        }, failure: { Error in
            print("Could not retreive id")
            print(Error.localizedDescription)
        })
        
    }
    @objc func displayProfile(){
        
        let myUrl="https://api.twitter.com/1.1/users/show.json"
      
        let myParams=["user_id":tweetId] as [String:Any]
        print(myParams)
        TwitterAPICaller.client?.getDictionaryRequest(url: myUrl, parameters: myParams, success: { (user: NSDictionary) in
            self.userObject=user
            self.updateLabel()
        }, failure: { Error in
            print("Could not retreive tweets")
            print(Error.localizedDescription)
        })
        //print(self.userObject)
        /*
        nameLabel.text=userObject["name"] as! String
        screenLabel.text=userObject["screen_name"] as! String
        tweetsLabel.text="\(userObject["statuses_count"] as! Int) Tweets"
        followingLabel.text="\(userObject["friends_count"] as! Int) Followers"
        followersLabel.text="\(userObject["followers_count"] as! Int) Followers"
        followingLabel.text="\(userObject["friends_count"] as! Int) Following"
      */
        
    }
    

   
    
    func updateLabel(){
        nameLabel.text=userObject["name"] as! String
        screenLabel.text="@\(userObject["screen_name"] as! String)"
        tweetsLabel.text="\(userObject["statuses_count"] as! Int) Tweets"
        followingLabel.text="\(userObject["friends_count"] as! Int) Followers"
        followersLabel.text="\(userObject["followers_count"] as! Int) Followers"
        followingLabel.text="\(userObject["friends_count"] as! Int) Following"
        bioLabel.text=userObject["description"] as! String
        let imageUrl=URL(string:(userObject["profile_image_url"] as? String)!)
        let data=try?Data(contentsOf: imageUrl!)
        if let imageData=data{
            imageView.image=UIImage(data: imageData)
        }
        
        let bannerUrl=URL(string:(userObject["profile_banner_url"] as? String)!)
        let data2=try?Data(contentsOf: bannerUrl!)
        if let bannerData=data2{
            bannerView.image=UIImage(data: bannerData)
        }
        
    }

}
