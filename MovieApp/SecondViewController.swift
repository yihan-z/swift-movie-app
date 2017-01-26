////
////  SecondViewController.swift
////  MovieApp
////
////  Created by ZhuangYihan on 10/13/16.
////  Copyright © 2016 ZhuangYihan. All rights reserved.
////
//
//import UIKit
//
//class SecondViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
//    
//    var currentFavs:[String] = []
//    let defaults = NSUserDefaults.standardUserDefaults()
//
//    @IBOutlet weak var theTable: UITableView!
//    
//    override func viewWillAppear(animated: Bool) {
//        theTable.reloadData()
//        
//        if (!(defaults.arrayForKey("Fav")?.isEmpty)!) {
//            currentFavs = defaults.arrayForKey("Fav") as! [String]
//        }
//        print("current favs are: \(currentFavs)")
//        
//        print("Data reloaded: \(currentFavs)")
//    }
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        theTable.dataSource = self
//
//        // Do any additional setup after loading the view, typically from a nib.
//        let defaults = NSUserDefaults.standardUserDefaults()
//        if (!(defaults.arrayForKey("Fav")?.isEmpty)!) {
//            currentFavs = defaults.arrayForKey("Fav") as! [String]
//        }
//        print("current favs are: \(currentFavs)")
//
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//    
//    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return currentFavs.count
//    }
//    
//    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        
//        print("in cellForRow at \(indexPath)")
//        
//        let myCell = UITableViewCell(style: .Default, reuseIdentifier: nil)
//        
//        myCell.textLabel!.text = currentFavs[indexPath.row]
//        
//        return myCell
//    }
//    
//    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
//        return true
//    }
//    
//    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
//        if (editingStyle == UITableViewCellEditingStyle.Delete) {
//            // handle delete (by removing the data from your array and updating the tableview)
//            currentFavs.removeAtIndex(indexPath.row)
//            defaults.setObject(currentFavs, forKey: "Fav")
//            defaults.synchronize()
//            var indexPaths:[NSIndexPath] = []
//            indexPaths.append(indexPath)
//            
//            theTable.beginUpdates()
//            theTable.deleteRowsAtIndexPaths(indexPaths, withRowAnimation: .Fade)
//            theTable.endUpdates()
//            
//        }
//    }
//
//}
//

//
//  SecondViewController.swift
//  MovieApp
//
//  Created by ZhuangYihan on 10/13/16.
//  Copyright © 2016 ZhuangYihan. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var currentFavs:[String] = []
    let defaults = NSUserDefaults.standardUserDefaults()
    
    @IBOutlet weak var theTable: UITableView!
    
    override func viewWillAppear(animated: Bool) {
        
        if (!(defaults.arrayForKey("Fav")?.isEmpty)!) {
            currentFavs = defaults.arrayForKey("Fav") as! [String]
        }
        theTable.reloadData()

//        print("current favs are: \(currentFavs)")
//        
        print("Data reloaded: \(currentFavs)")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        theTable.dataSource = self
        
        // Do any additional setup after loading the view, typically from a nib.
//        let defaults = NSUserDefaults.standardUserDefaults()
        if (!(defaults.arrayForKey("Fav")?.isEmpty)!) {
            currentFavs = defaults.arrayForKey("Fav") as! [String]
        }
        print("current favs are: \(currentFavs)")
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("there are \(currentFavs.count) rows")
        return currentFavs.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        print("in cellForRow at \(indexPath)")
        let myCell = UITableViewCell(style: .Default, reuseIdentifier: nil)
        myCell.textLabel!.text = currentFavs[indexPath.row]
        return myCell
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            // handle delete (by removing the data from your array and updating the tableview)
            currentFavs.removeAtIndex(indexPath.row)
            defaults.setObject(currentFavs, forKey: "Fav")
            defaults.synchronize()
            var indexPaths:[NSIndexPath] = []
            indexPaths.append(indexPath)
            
            theTable.beginUpdates()
            theTable.deleteRowsAtIndexPaths(indexPaths, withRowAnimation: .Fade)
            theTable.endUpdates()
            
        }
    }
    
}


