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
    
    // Explained here: http://blog.johnregner.com/post/103092814578/swift-properties-custom-setters-and-getters
    var post: SMPost! {
        didSet {
            configureView()
        }
    }
    
    func configureView() {
        if let
            title = post.postTitle,
            body = post.postBody {
                titleField.text = title
                bodyTextView.text = body
        }
    }
    
    func savePost(sender: AnyObject) {
        post.postTitle = titleField.text
        post.postBody = bodyTextView.text
        var defaultCenter = NSNotificationCenter()
        defaultCenter.addObserver(self, selector: "reload", name: "POST_UPDATED", object: nil)
        if let navigationController = navigationController {
            navigationController.popViewControllerAnimated(true)
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
