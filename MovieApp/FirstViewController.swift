//
//  FirstViewController.swift
//  MovieApp
//
//  Created by ZhuangYihan on 10/13/16.
//  Copyright © 2016 ZhuangYihan. All rights reserved.
//
//


import UIKit

class FirstViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UIScrollViewDelegate {
    
    var myArray:[Movie] = []
    var theImageCache:[UIImage] = []
    
    var infoFrame = UIView()
    var activityIndicator = UIActivityIndicatorView()
    var strLabel = UILabel()

    @IBOutlet weak var theTextField: UITextField!
    @IBOutlet weak var theButton: UIButton!
    
    @IBOutlet weak var theCollection: UICollectionView!

    
    func progressBarDisplayer(msg:String, _ indicator:Bool ) {
        print(msg)
        strLabel = UILabel(frame: CGRect(x: 50, y: 0, width: 200, height: 50))
        strLabel.text = msg
        strLabel.textColor = UIColor.whiteColor()
        infoFrame = UIView(frame: CGRect(x: view.frame.midX - 100, y: view.frame.midY - 25 , width: 200, height: 50))
        infoFrame.layer.cornerRadius = 15
        infoFrame.backgroundColor = UIColor(white: 0, alpha: 0.7)
        if indicator {
            activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.White)
            activityIndicator.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
            activityIndicator.startAnimating()
            infoFrame.addSubview(activityIndicator)
        }
        infoFrame.addSubview(strLabel)
        view.addSubview(infoFrame)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        theCollection.dataSource = self
        theCollection.delegate = self
        view.addSubview(theCollection)
        
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED,0)){
            
            dispatch_async(dispatch_get_main_queue()){
                self.theCollection.reloadData()
            }
        }
    
    }
    
    @IBAction func clickedSearch(sender: AnyObject) {
        self.theCollection.reloadData()
        let word = theTextField.text!
        if (word.isEmpty || word.characters.count==1) {
            let alert = UIAlertController(title: "Invalid Input", message: "Must provide more than one character", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        } else {
            var searchword:[Character] = []
            for char in word.characters {
                if (char == " ") {
                    searchword.append("+")
                } else {
                    searchword.append(char)
                }
            }
            let searchstring = String(searchword)
            
            progressBarDisplayer("Searching...", true)

            theButton.enabled = false

            
            dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED,0)){
                self.myArray.removeAll()
                self.theImageCache.removeAll()
                self.fetchData(searchstring)

                dispatch_async(dispatch_get_main_queue()){
//                self.theTableView.reloadData()
                    self.cacheImages()
                    self.theCollection.reloadData()
                    self.infoFrame.removeFromSuperview()
                    self.theButton.enabled = true
                }
            }
        }
    }
    
    func fetchData(word:String) {
        for i in 1...3 {
            let json = getJSON("http://omdbapi.com/?s=\(word)&page=\(i)&r=json")
            
            for result in json["Search"].arrayValue {
                let title = result["Title"].stringValue
                let year = result["Year"].stringValue
                let imdbID = result["imdbID"].stringValue
                let type = result["Type"].stringValue
                let poster = result["Poster"].stringValue
            
                myArray.append(Movie(title: title, year: year, imdbID: imdbID, type: type, poster: poster))
            }
        }
        print(myArray)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    private func getJSON(url: String) -> JSON {
        
        if let nsurl = NSURL(string: url){
            if let data = NSData(contentsOfURL: nsurl) {
                let json = JSON(data: data)
                return json
            } else {
                return nil
            }
        } else {
            return nil
        }
    }
    
    func cacheImages() {
        
        for item in myArray {
            
            let url = NSURL(string: item.poster)
            let dataOp = NSData(contentsOfURL: url!)
            if let data = dataOp {
                let image = UIImage(data: data)
                theImageCache.append(image!)
                
            } else {
                theImageCache.append(UIImage(named: ("placeholder"))!)
            }
        }
    }
    

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return myArray.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("movie", forIndexPath: indexPath) as! MovieCell
        cell.movieImage.image = theImageCache[indexPath.row]
        cell.movieTitle.text = myArray[indexPath.row].title

        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier {
            if (identifier=="DetailedSegue") {
                if let newVC = segue.destinationViewController as? Detail {
                    let path = self.theCollection.indexPathForCell(sender as! UICollectionViewCell)
                    newVC.image = theImageCache[path!.row]
                    newVC.name = myArray[path!.row].title
                    newVC.year = myArray[path!.row].year
                    newVC.type = myArray[path!.row].type
                    newVC.imdb = myArray[path!.row].imdbID
                }
            }
        }

    }

}
    


