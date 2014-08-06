//
//  MessageTableViewCell.swift
//  MessengerPrototype
//
//  Created by Anthony Giugno on 2014-07-19.
//  Copyright (c) 2014 Anthony Giugno. All rights reserved.
//

import UIKit

class MessageTableViewCell: UITableViewCell {
    @IBOutlet var messageLabel : UILabel!
    @IBOutlet var msgBubble : UIView!
    @IBOutlet var userImageView: UIImageView!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        // Initialization code
    }
    
    required init(coder aDecoder: NSCoder!) { //requirement from XCode 6 Beta 5
        super.init(coder: aDecoder)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = UITableViewCellSelectionStyle.None
        self.messageLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping
        self.messageLabel.numberOfLines = 0
        self.layer.masksToBounds = true
        self.msgBubble.layer.cornerRadius = 5.0
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
