//
//  LevelFourViewController.swift
//  Debugging
//
//  Created by Nicholas Aiwazian on 2/4/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit

// TableView with no cells
class LevelFourViewController: GameLevelViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var movies: [AnyObject]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "SimpleMovieTableViewCell", bundle: nil)
        self.tableView.registerNib(nib, forCellReuseIdentifier: "simpleMovieCell")
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.loadJSON()
    }
    
    func loadJSON() {
        let filePath = NSBundle.mainBundle().pathForResource("Movies", ofType: "json")
        let fileData = NSData.init(contentsOfFile: filePath!)
        
        do {
            if let responseDictionary = try NSJSONSerialization.JSONObjectWithData(fileData!,
                options:NSJSONReadingOptions(rawValue:0)) as? [String:AnyObject] {
                    
                    if let movies = responseDictionary["movies"] as? [AnyObject] {
                        self.movies = movies
                    }
            }
        } catch {
            print("Error parsing JSON")
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let movies = movies {
            return movies.count
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("simpleMovieCell") as! SimpleMovieTableViewCell
        let movie = self.movies[indexPath.row] as? [String:AnyObject]
        cell.titleLabel.text = movie!["title"] as? String
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        self.didFinishLevel()
    }
}
