//
//  HomeViewController.swift
//  Debugging
//
//  Created by Nicholas Aiwazian on 2/4/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, GameLevelViewControllerDelegate {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!
    
    let lastLevelCompletedKey = "last_level_completed"
    let userDefaults = NSUserDefaults.standardUserDefaults()
    
    var currentLevel = 0

    let levels = [
        GameLevel(number: 1, viewController: LevelOneViewController(), detailedDescription: "The dreaded key-value coding compliant error! This level shows you how to debug a key-value coding compliant error. If you can prevent the next view controller from crashing, you'll pass the level!"),
        GameLevel(number: 2, viewController: LevelTwoViewController(), detailedDescription: "Uncaught exceptions! This level shows you how to debug an uncaught exception. If you can fix the crash in the next view controller, you'll pass the level!"),
        GameLevel(number: 3, viewController: LevelThreeViewController(), detailedDescription: "My view doesn't respond to taps! We'll look at how to debug view layout issues. If you can tap on the `Finish Level` button, you'll pass the level!"),
        GameLevel(number: 4, viewController: LevelFourViewController(), detailedDescription: "Where are my cells??? Figure out a way to get the tableView cells to show up to advance to the next level!"),
        GameLevel(number: 5, viewController: LevelFiveViewController(), detailedDescription: "What's wrong with my cells? Figure out why the cells are wrong to advance to the next level!"),
        GameLevel(number: 6, viewController: LevelSixViewController(), detailedDescription: "Unsatisfiable AutoLayout Constraints. Fix the AutoLayout constraints to advance to the next level!"),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Sets to level zero if no progress saved
        self.currentLevel = userDefaults.integerForKey(lastLevelCompletedKey)
        
        self.detailsLabel.text = "Welcome to the Debugging Game! This game has \(self.levels.count) levels. Each level has a bug. It is your responsibility to debug each issue and fix it to advance to the next level."
    }
    
    @IBAction func startGameTapped(sender: AnyObject) {
        self.launchNextLevel()
    }
    
    func didFinishLevel() {
        userDefaults.setInteger(self.currentLevel + 1, forKey: lastLevelCompletedKey)
        userDefaults.synchronize()
        
        if self.currentLevel == self.levels.count - 1 {
            self.launchGameComplete()
        } else {
            self.currentLevel++
            self.launchNextLevel()
        }
    }
    
    func launchNextLevel() {
        
        let introViewController = LevelIntroductionViewController()
        introViewController.gameLevel = levels[currentLevel]
        
        let actualViewController = levels[currentLevel].viewController as GameLevelViewController
        actualViewController.delegate = self
        
        self.navigationController?.pushViewController(introViewController, animated: true)
    }
    
    func launchGameComplete() {
        let vc = GameCompleteViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
