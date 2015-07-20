//
//  ReminderTableViewCell.swift
//  UTBus
//
//  Created by Dilip Ojha on 2015-06-29.
//  Copyright (c) 2015 madlab. All rights reserved.
//

import UIKit

class ReminderTableViewCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSubtitle: UILabel!
    @IBOutlet weak var lblBackground: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
                
        lblBackground.layer.cornerRadius = 5;
        lblBackground.layer.masksToBounds = true;
        
        self.layoutMargins = UIEdgeInsetsZero
        
        //var shadowPath: UIBezierPath = UIBezierPath(rect: lblBackground.bounds)
        
        /*lblBackground.layer.masksToBounds = false;
        lblBackground.layer.shadowColor = UIColor.blackColor().CGColor;
        lblBackground.layer.shadowOffset = CGSizeMake(0.0, 5.0);
        lblBackground.layer.shadowOpacity = 0.5;
        lblBackground.layer.shadowPath = shadowPath.CGPath;*/
        
        self.contentView.backgroundColor = UIColor.clearColor()
        self.backgroundView?.backgroundColor = UIColor.clearColor()
        self.backgroundColor = UIColor.clearColor()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
