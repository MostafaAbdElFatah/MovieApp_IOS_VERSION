//
//  FavoriteViewController.swift
//  MoviesApp
//
//  Created by Mostafa AbdEl Fatah on 10/11/18.
//  Copyright © 2018 Mostafa AbdEl Fatah. All rights reserved.
//

import UIKit

class FavoriteViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var moviesList:[Movie] = []
    let realmManager = RealmManager()
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // get favorite movies from realm database
        moviesList.append(contentsOf: realmManager.getMovies())
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesList.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as! MovieTableCell
        let movie = moviesList[indexPath.row] as Movie
        
        cell.movieNameLabel.text    = movie.movieName
        cell.movieYearLabel.text    = "\(String(describing: movie.movieYear))"
        cell.movieTaglineLabel.text  = movie.movieTagline
        cell.movieDirectorLabel.text = movie.movieDirector
        cell.movieDurationLabel.text = movie.movieDuration
        
        API.downloadImage(image: movie.movieImage) { data in
            if let image = data{
                cell.movieImage.image = UIImage(data: image)
            }
        }
        
        return cell
    }

}
