//
//  SMDetailViewController.swift
//  DearDiary
//
//  Created by Matthew Finlayson on 5/8/15.
//  Copyright (c) 2015 Cesare Rocchi. All rights reserved.
//

import Foundation
import NotificationCenter

class SMDetailViewController: UIViewController {
    
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var bodyTextView: UITextView!
    
    var post: SMPost!
    
    func configureView() {
        if let
            title = post.postTitle,
            body = post.postBody {
                self.titleField.text = title
                self.bodyTextView.text = body
        }
    }
    
    func savePost(sender: AnyObject) {
        post.postTitle = titleField.text
        post.postBody = bodyTextView.text
        
        post.saveObjectWithCompletion { (object: AnyObject!, error: NSError!) -> Void in
            if error == nil {
                NSLog("object saved")
                self.post = object as? SMPost
                NSNotificationCenter().addObserver(self, selector: "reload", name: "POST_UPDATED", object: nil)
                if let navigationController = self.navigationController {
                    navigationController.popViewControllerAnimated(true)
                }
            } else {
                NSLog("error in updating \(error)")
            }
        }
    }
    
    override func viewDidLoad() {        
        let frame = CGRect(x: 0, y: 0, width: 5, height: 20)
        let paddingView = UIView(frame: frame)
        titleField.leftView = paddingView
        titleField.leftViewMode = .Always
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: UIBarButtonItemStyle.Bordered, target: self, action: "savePost:")
        configureView()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        titleField.becomeFirstResponder()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
