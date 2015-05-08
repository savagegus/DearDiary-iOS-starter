//
//  SMMasterViewController.swift
//  DearDiary
//
//  Created by Matthew Finlayson on 5/7/15.
//  Copyright (c) 2015 Cesare Rocchi. All rights reserved.
//

import UIKit
import NotificationCenter

class SMMasterViewController: UITableViewController {

    var posts: NSMutableArray = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "createPost")
        navigationItem.rightBarButtonItem = addButton
        var defaultCenter = NSNotificationCenter()
        defaultCenter.addObserver(self, selector: "reload", name: "POST_UPDATED", object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func reload() {
        tableView.reloadData()
    }

    func createPost() {
        var post = SMPost()
        post.postTitle = "No title \(posts.count)"
        post.postBody = "No body"
        
        posts.insertObject(post, atIndex: 0)
        if let indexPath = NSIndexPath(forRow: posts.count - 1, inSection: 0) {
            tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell"
        
        var cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as? UITableViewCell
            
        if cell == nil {
            cell = UITableViewCell(style: .Subtitle, reuseIdentifier: cellIdentifier)
            cell!.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        }
        
        let post = posts[indexPath.row] as! SMPost
        cell!.textLabel!.text = post.postTitle
        cell!.detailTextLabel!.text = post.postBody
        return cell!
    }

    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            
            if let indexPath = tableView.indexPathForSelectedRow() {
                if let destination = segue.destinationViewController as? SMDetailViewController {
                    let post = posts[indexPath.row] as! SMPost
                    destination.post = post
                }
            }
        }
    }

}
