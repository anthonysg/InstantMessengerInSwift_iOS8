//
//  ContainerViewController.swift
//  MessengerPrototype
//
//  Created by Anthony Giugno on 2014-07-21.
//  Copyright (c) 2014 Anthony Giugno. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var baseConstraint : NSLayoutConstraint!
    @IBOutlet var textField : UITextField!
    @IBOutlet var toolBar : UIToolbar!
    @IBOutlet var containerViewController : UIView!
    @IBOutlet var lightGreyBorder : UIView!
    
    var child : MessengerTableViewController?
    var childView : UITableView?
    var msgDelegate : MessengerTableViewControllerDelegate?
    
    required init(coder aDecoder: NSCoder!) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.textField.delegate = self
        registerForKeyboardNotifications()
        toolBar.clipsToBounds = true
        self.view.bringSubviewToFront(lightGreyBorder)
        /* **FOR INPUTACCESSORYVIEW IMPLEMENTATION OF UITEXTFIELD** refer to https://github.com/666tos/CustomAccessoryViewSample **for iOS8** */
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue?, sender: AnyObject?) {
        // Get the new view controller using segue!.destinationViewController. ContainerViewControllers execute this method when loading their contents.
        println(segue!.identifier)
        if segue?.identifier == "tableView" {
            
            child = segue!.destinationViewController as? MessengerTableViewController
            childView = segue!.destinationViewController.view as? UITableView
            self.msgDelegate = child
        }
        // Passes the selected objects to the new view controller.
    }

    func textFieldShouldReturn(textField: UITextField!) -> Bool {
        if (self.textField.text == ""){
            return true }
        child!.messages.append(textField.text)
        self.textField.text = ""
        childView!.reloadData()
        self.msgDelegate!.messengerScrollToBottom(firstTimeOccurring: false)
        return true
    }
    
    //Keyboard Notifications
    
    func registerForKeyboardNotifications()
        
    {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillBeHidden:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func keyboardWillShow(aNotification: NSNotification)    {
        //Collect information about keyboard using its notification.
        let info = aNotification.userInfo
        let duration = (info[UIKeyboardAnimationDurationUserInfoKey] as NSValue) as Double
        let curve = (info[UIKeyboardAnimationCurveUserInfoKey] as NSValue) as UInt
        let kbFrame = (info[UIKeyboardFrameEndUserInfoKey] as NSValue).CGRectValue()
        //Adjust location of UITextField/UIToolBar.
        baseConstraint.constant = kbFrame.size.height
        self.view.setNeedsUpdateConstraints()
        //Animate it into place.
        UIView.animateWithDuration(duration, delay: 0, options: UIViewAnimationOptions.fromMask(curve), animations: {
        self.view.layoutIfNeeded()
        }, completion: {
        (value: Bool) in println()
        })
        //Scroll to bottom of screen.
        self.msgDelegate!.messengerScrollToBottom(firstTimeOccurring: false)
    }
    
    func keyboardWillBeHidden(aNotification: NSNotification)    {
        let info = aNotification.userInfo
        let duration = (info[UIKeyboardAnimationDurationUserInfoKey] as NSValue) as Double
        let curve = (info[UIKeyboardAnimationCurveUserInfoKey] as NSValue) as UInt
        
        baseConstraint.constant = 0
        self.view.setNeedsUpdateConstraints()
        
        UIView.animateWithDuration(duration, delay: 0, options: UIViewAnimationOptions.fromMask(curve), animations: {
            self.view.layoutIfNeeded()
            }, completion: {
                (value: Bool) in println()
            })
    }
    
    //Bugs
    //-Improperly adjusting containerViewController on iPhone5/iPhone5s for Landscape Mode. (ContentInset bug (?))
    
    //Features To Implement
    //-"Send" Button on toolBar
    //-'slowly' dismiss keyboard (inputAccessibleView required)
    //-textField starts new line after series of characters (multiline text view)
}
