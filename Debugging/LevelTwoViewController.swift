//
//  LevelTwoViewController.swift
//  Debugging
//
//  Created by Nicholas Aiwazian on 2/4/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit

// Exception that isn't caught
class LevelTwoViewController: GameLevelViewController {
    
    @IBOutlet weak var attributedLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myString = NSMutableAttributedString(string: "funWithAttributedStrings")
        myString.addAttribute(NSForegroundColorAttributeName, value: UIColor.redColor(), range: NSMakeRange(0, 3))
        myString.addAttribute(NSForegroundColorAttributeName, value: UIColor.greenColor(), range: NSMakeRange(3, 4))
        myString.addAttribute(NSForegroundColorAttributeName, value: UIColor.blueColor(), range: NSMakeRange(7, 10))
        myString.addAttribute(NSForegroundColorAttributeName, value: UIColor.orangeColor(), range: NSMakeRange(17, 8))
        self.attributedLabel.attributedText = myString
    }    
}
