//
//  SMLoginViewController.swift
//  DearDiary
//
//  Created by Matthew Finlayson on 5/8/15.
//  Copyright (c) 2015 Cesare Rocchi. All rights reserved.
//

import Foundation


class SMLoginViewController : UIViewController {
    @IBOutlet weak var loginView: UIView!
    @IBOutlet weak var signupView: UIView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBOutlet weak var loginUsernameField: UITextField!
    @IBOutlet weak var loginPasswordField: UITextField!
    
    @IBOutlet weak var signupUsernameField: UITextField!
    @IBOutlet weak var signupPasswordField: UITextField!
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil);
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        segmentedControl.addTarget(
            self,
            action: "segmentedControllTapped:",
            forControlEvents: UIControlEvents.ValueChanged)
    }
    
    
    func segmentedControllTapped(sender: AnyObject) {
        updateView()
    }
    
    func updateView() {
        if segmentedControl.selectedSegmentIndex == 0 {
            UIView.animateWithDuration(0.5, animations: {
                self.loginView.alpha = 1
                self.signupView.alpha = 0
            })
        } else {
            UIView.animateWithDuration(0.5, animations: {
                self.loginView.alpha = 1;
                self.signupView.alpha = 0;
            })
        }
    }
    
    @IBAction func login() {
        NSLog("Login")
        let client = BAAClient.sharedClient()
        client.authenticateUser(loginUsernameField.text,
            password: loginPasswordField.text,
            completion: {(success, error) in
                if(success) {
                    NSLog("user authenticated \(client.currentUser)")
                    self.dismissViewControllerAnimated(true, completion: nil)
                } else {
                    NSLog("error in logging in \(error)")
                }
        })
    }
    
    @IBAction func signup() {
        NSLog("Signup")
        let client = BAAClient.sharedClient()
        client.createUserWithUsername(loginUsernameField.text,
            password: loginPasswordField.text,
            completion: {(success, error) in
                if(success) {
                    NSLog("user created \(client.currentUser)")
                    self.dismissViewControllerAnimated(true, completion: nil)
                } else {
                    NSLog("error in creating user \(error)")
                }
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

