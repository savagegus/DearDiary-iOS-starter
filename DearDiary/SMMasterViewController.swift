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
        
        // We don't want the default deselection animation, we handle it ourselves in -viewWillAppear
        clearsSelectionOnViewWillAppear = false;
        
        // Makes the table view automatically calculate row heights
        tableView.estimatedRowHeight = 44.0;
        tableView.rowHeight = UITableViewAutomaticDimension;
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "createPost")
        navigationItem.rightBarButtonItem = addButton
        NSNotificationCenter().addObserver(self, selector: "reload", name: "POST_UPDATED", object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        addCellDeselectionAnimation()

        let client = BAAClient.sharedClient()
        if client.isAuthenticated() {
            NSLog("Logged in")
            SMPost.getObjectsWithCompletion({ (objects: [AnyObject]!, error: NSError!) -> Void in
                self.posts = NSMutableArray(array: objects)
                self.tableView.reloadData()
            })
        } else {
            NSLog("need to login/signup")
            let loginViewController = SMLoginViewController(nibName: "SMLoginViewController", bundle: nil)
            navigationController?.presentViewController(loginViewController, animated: true, completion: nil)
        }
    }
    
    func reload() {
        tableView.reloadData()
    }

    func createPost() {
        var post = SMPost()
        post.postTitle = "No title \(posts.count)"
        post.postBody = "No body"
        
        post.saveObjectWithCompletion { (post: AnyObject!, error: NSError!) -> Void in
            if error == nil {
                NSLog("created post on server \(post)")
                self.posts.insertObject(post, atIndex: 0)
                if let indexPath = NSIndexPath(forRow: self.posts.count - 1, inSection: 0) {
                    self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
                }
            } else {
                NSLog("error in saving \(error)")
            }
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
    
    // This will animate the deselection of the selected table row along with the standard animation
    func addCellDeselectionAnimation() {
        if let indexPath = tableView.indexPathForSelectedRow() {
            if let cell = tableView.cellForRowAtIndexPath(indexPath) {
                if let initiallyInteractive = transitionCoordinator()?.initiallyInteractive() {
                    if let presented = isBeingPresented() == true {
                        if let !isMovingToParentViewController == true
                    }!isMovingToParentViewController == true {
                            
                        }
                }
                
                isBeingPresented() != nil &&
                    isMovingToParentViewController() {
                        
                }
            }
        }
        
        
        
        UITableView *tableView = self.tableView;
        NSIndexPath *indexPath = [tableView indexPathForSelectedRow];
        
        if (indexPath) {
            UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            
            // In this case, I am appearing, but am already in a parent view controller
            if (self.transitionCoordinator && self.transitionCoordinator.initiallyInteractive && !self.isBeingPresented && !self.isMovingToParentViewController) {
                
                [self.transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
                    
                    [cell setSelected:NO animated:YES];
                    
                    } completion:^(id<UIViewControllerTransitionCoordinatorContext> context) {
                    if (context.isCancelled) {
                    // Reverse the cell selection process
                    [cell setSelected:YES animated:NO];
                    } else {
                    // Tell the table about the selection
                    [tableView deselectRowAtIndexPath:indexPath animated:NO];
                    }
                    }];
                
            } else {
                [tableView deselectRowAtIndexPath:indexPath animated:YES];
            }
        }
    }
}
