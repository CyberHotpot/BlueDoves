//
//  TweetViewController.swift
//  Twitter
//
//  Created by rodeo station on 10/4/22.
//  Copyright © 2022 Dan. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController {

    @IBOutlet weak var tweetTextView: UITextView!
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tweetTextView.becomeFirstResponder()
        
    }
    
    @IBAction func tweet(_ sender: Any) {
        if(!tweetTextView.text.isEmpty){
            TwitterAPICaller.client?.postTweet(tweetString: tweetTextView.text, success: {
                self.dismiss(animated: true, completion: nil)
            }, failure: { (error) in
                print("Error posting tweet \(error)")
                self.dismiss(animated: true, completion: nil)
            })
        }
    }
    
    

}
