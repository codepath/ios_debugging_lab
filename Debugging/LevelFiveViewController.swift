//
//  LevelFiveViewController.swift
//  Debugging
//
//  Created by Nicholas Aiwazian on 2/4/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit
import AFNetworking

// TableView with cells with wrong descriptions
class LevelFiveViewController: GameLevelViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!

    let posterBaseUrl = "http://image.tmdb.org/t/p/w500"
    var movies: [AnyObject]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.estimatedRowHeight = 100
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        let nib = UINib(nibName: "MovieTableViewCell", bundle: nil)
        self.tableView.registerNib(nib, forCellReuseIdentifier: "movieCell")
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
                        self.tableView.reloadData()
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
        let cell = tableView.dequeueReusableCellWithIdentifier("movieCell") as! MovieTableViewCell
        let movie = self.movies[indexPath.row] as? [String:AnyObject]
        
        let posterUrl = NSURL(string: posterBaseUrl + (movie!["poster_path"] as! String))
        
        cell.posterImageView.setImageWithURL(posterUrl!)
        cell.titleLabel.text = movie!["title"] as? String
        
        if let movieOverview = movie?["overview"] as? String {
            cell.overviewLabel.text = movieOverview
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        self.didFinishLevel()
    }
}
