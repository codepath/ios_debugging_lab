//
//  LevelIntroductionViewController.swift
//  Debugging
//
//  Created by Nicholas Aiwazian on 2/9/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit

class LevelIntroductionViewController: UIViewController {

    var gameLevel: GameLevel!
    
    @IBOutlet weak var levelNumberLabel: UILabel!
    @IBOutlet weak var detailedDescriptionLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.levelNumberLabel.text = String(self.gameLevel.number)
        self.detailedDescriptionLabel.text = self.gameLevel.detailedDescription
    }
    
    @IBAction func playLevel(sender: AnyObject) {
        self.navigationController?.pushViewController(self.gameLevel.viewController, animated: true)
    }
}
