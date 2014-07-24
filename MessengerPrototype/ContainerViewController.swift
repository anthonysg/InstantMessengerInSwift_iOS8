//
//  ContainerViewController.swift
//  MessengerPrototype
//
//  Created by Anthony Giugno on 2014-07-21.
//  Copyright (c) 2014 Anthony Giugno. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var baseConstraint : NSLayoutConstraint
    @IBOutlet var textField : UITextField
    @IBOutlet var toolBar : UIToolbar
    @IBOutlet var containerViewController : UIView
    @IBOutlet var lightGreyBorder : UIView
    
    var child : MessengerTableViewController?
    var childView : UITableView? //UIView?
    var contentOffset : NSNumber?
    
    init(coder aDecoder: NSCoder!) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.textField.delegate = self
        registerForKeyboardNotifications()
        toolBar.clipsToBounds = true
        self.view.bringSubviewToFront(lightGreyBorder)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func editingDidBegin(sender : AnyObject) {
        
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue?, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController ].
        var name = segue?.identifier
        if segue?.identifier == "tableView" {
            
            child = segue!.destinationViewController as? MessengerTableViewController
            childView = segue!.destinationViewController.view as? UITableView
            contentOffset = segue!.destinationViewController.contentOffset.y
            
        }
        // Pass the selected object to the new view controller.
    }

    func textFieldShouldReturn(textField: UITextField!) -> Bool {
        self.textField.resignFirstResponder()
        return true
    }
    
/*    func textFieldDidBeginEditing(textField: UITextField!) { //Come back to this to optimize textField movement.
        self.view.setNeedsLayout()
        baseConstraint.constant = 211
        self.view.setNeedsUpdateConstraints()
        
        UIView.animateWithDuration(0.30, animations: {
            self.view.layoutIfNeeded()
            })
        
    }
    */
    
    // Called when the UIKeyboardDidShowNotification is sent.
    
    func registerForKeyboardNotifications()
        
    {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillBeHidden:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func keyboardWillShow(aNotification: NSNotification)    {
        
        let duration = aNotification.userInfo.objectForKey(UIKeyboardAnimationDurationUserInfoKey) as Double
        let curve = aNotification.userInfo.objectForKey(UIKeyboardAnimationCurveUserInfoKey) as UInt
        
        //self.view.setNeedsLayout()
        baseConstraint.constant = 211
        self.view.setNeedsUpdateConstraints()
        
        UIView.animateWithDuration(duration, delay: 0, options: UIViewAnimationOptions.fromMask(curve), animations: {
        self.view.layoutIfNeeded()
        }, completion: {
        (value: Bool) in println()
        })
    }
    
    // Called when the UIKeyboardWillHideNotification is sent
    
    func keyboardWillBeHidden(aNotification: NSNotification)    {
        
        let duration = aNotification.userInfo.objectForKey(UIKeyboardAnimationDurationUserInfoKey) as Double
        let curve = aNotification.userInfo.objectForKey(UIKeyboardAnimationCurveUserInfoKey) as UInt
        
        //self.view.setNeedsLayout()
        baseConstraint.constant = 0
        self.view.setNeedsUpdateConstraints()
        
        self.textField.resignFirstResponder()
        
        UIView.animateWithDuration(duration, delay: 0, options: UIViewAnimationOptions.fromMask(curve), animations: {
            self.view.layoutIfNeeded()
            }, completion: {
                (value: Bool) in println()
            })

        
    }
    
    //Bugs
    //-scroll to bottom of tableView when keyboard activates
    //-textField starts new line after series of characters
    //-"Send" Button
    //-'slowly' dismiss keyboard
}
