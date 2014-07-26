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
    var childView : UITableView?
    var msgDelegate : MessengerTableViewControllerDelegate?
    
    init(coder aDecoder: NSCoder!) {
        super.init(coder: aDecoder)
        //self.msgDelegate = MessengerTableViewController(coder: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.textField.delegate = self
        registerForKeyboardNotifications()
        toolBar.clipsToBounds = true
        self.view.bringSubviewToFront(lightGreyBorder)
        
 
       var textF = UITextField(frame: CGRectMake(0, 300, self.textField.frame.size.width, self.textField.frame.size.height))
        textF.backgroundColor = UIColor.redColor()
        self.view.addSubview(textF)
        
        var textF2 = UITextField()
        textF2.borderStyle = UITextBorderStyle.None
        textF2.frame.size = CGSizeMake(300, 300)
        textF2.text = self.textField.text
        textF2.backgroundColor = UIColor.whiteColor()
        
        textF.inputAccessoryView = textF2
        textF2.frame.size = CGSizeMake(300, 300)
        //self.view.addSubview(textF)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue?, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController ].
        println(segue!.identifier)
        if segue?.identifier == "tableView" {
            
            child = segue!.destinationViewController as? MessengerTableViewController
            childView = segue!.destinationViewController.view as? UITableView
            self.msgDelegate = child
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
/*        let duration = aNotification.userInfo.objectForKey(UIKeyboardAnimationDurationUserInfoKey) as Double
        let curve = aNotification.userInfo.objectForKey(UIKeyboardAnimationCurveUserInfoKey) as UInt
        
        //self.view.setNeedsLayout()
        baseConstraint.constant = 211
        self.view.setNeedsUpdateConstraints()
        //self.childView!.setNeedsUpdateConstraints()
        
        UIView.animateWithDuration(duration, delay: 0, options: UIViewAnimationOptions.fromMask(curve), animations: {
        self.view.layoutIfNeeded()
        }, completion: {
        (value: Bool) in println()
        })
        
        self.msgDelegate!.messengerScrollToBottom(firstTimeOccurring: false) */
    }
    
    // Called when the UIKeyboardWillHideNotification is sent
    
    func keyboardWillBeHidden(aNotification: NSNotification)    {
        /*
        
        let duration = aNotification.userInfo.objectForKey(UIKeyboardAnimationDurationUserInfoKey) as Double
        let curve = aNotification.userInfo.objectForKey(UIKeyboardAnimationCurveUserInfoKey) as UInt
        
        baseConstraint.constant = 0
        self.view.setNeedsUpdateConstraints()
        
        UIView.animateWithDuration(duration, delay: 0, options: UIViewAnimationOptions.fromMask(curve), animations: {
            self.view.layoutIfNeeded()
            //self.view.layoutSubviews()
            //self.view.setNeedsLayout()
            //self.childView!.layoutIfNeeded()
            }, completion: {
                (value: Bool) in println()
            }) */
    }
    
    //Bugs
    //-scroll to bottom of tableView when keyboard activates
    //-fix landscape mode autolayout for baseConstraint (toolbar/textfield fill whole screen).
    //-fix baseConstraint on iPad as well / Clean up code from modifying this stuff.
    //-Take a look at 'delayed autolayout' bug
    //-textField starts new line after series of characters
    //-"Send" Button on toolBar
    //-'slowly' dismiss keyboard
}
