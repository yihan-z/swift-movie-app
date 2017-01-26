//
//  Detail.swift
//  MovieApp
//
//  Created by ZhuangYihan on 10/18/16.
//  Copyright © 2016 ZhuangYihan. All rights reserved.
//

import Foundation
import UIKit
import Social

class Detail:UIViewController {
    var image: UIImage!
    var name: String!
    var year: String!
    var type: String!
    var imdb: String!
//    var movie: Movie!
    var prefs = NSUserDefaults.standardUserDefaults()

    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var IDLabel: UILabel!
    
    @IBOutlet weak var twitterButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieImage.image = image
        movieImage.contentMode = UIViewContentMode.ScaleAspectFit
        yearLabel.text = year
        typeLabel.text = type
        IDLabel.text = imdb
        
        // Do any additional setup after loading the view.

        let favBtn = UIBarButtonItem.init(barButtonSystemItem: .Add, target: self, action: #selector(addFav))

        //.... Set Right/Left Bar Button item
        self.navigationItem.rightBarButtonItem = favBtn
        
        twitterButton.setImage(UIImage(named: "twitter")?.imageWithRenderingMode(.AlwaysOriginal), forState: .Normal)
        twitterButton.imageView?.contentMode = UIViewContentMode.ScaleAspectFit
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        navigationItem.title = name
        
    }
    
    
    func addFav(){
        let defaults = NSUserDefaults.standardUserDefaults()
        var favorites:[String] = []
        if let currentFavs = defaults.arrayForKey("Fav") {
            var exist = false
            for aFav in currentFavs {
                if (aFav as! String == name) {
                    let alert = UIAlertController(title: "Already in Favoties", message: "This movie is already in your Favorites", preferredStyle: UIAlertControllerStyle.Alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                    self.presentViewController(alert, animated: true, completion: nil)
                    exist = true
                    break
                }
                
            }
            if (exist == false) {
                favorites = currentFavs as! [String]
                favorites.append(name)
                print("added favorite")
                let alert = UIAlertController(title: "Added to Favoties", message: "This movie is now in your Favorites", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
            }
        }
        prefs.setObject(favorites, forKey: "Fav")
        prefs.synchronize()
        self.viewDidLoad()
    }
    
    @IBAction func twitterButtonPushed(sender: UIButton) {
        if SLComposeViewController.isAvailableForServiceType(SLServiceTypeTwitter){
            var twitterSheet:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
            twitterSheet.setInitialText("Share on Twitter")
            self.presentViewController(twitterSheet, animated: true, completion: nil)
        } else {
            var alert = UIAlertController(title: "Accounts", message: "Please login to a Twitter account to share.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
}