//
//  ViewController.swift
//  MoviesApp
//
//  Created by Mostafa AbdEl Fatah on 10/11/18.
//  Copyright © 2018 Mostafa AbdEl Fatah. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var moviesList:[Movie] = []
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.refresh()
        
    }

    @IBAction func refresh_btnClicked(_ sender: UIBarButtonItem) {
        self.refresh()
    }
    
    func refresh(){
        let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
        
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        loadingIndicator.startAnimating();
        
        alert.view.addSubview(loadingIndicator)
        self.present(alert, animated: true, completion: nil)
        
        API.fetchMovies { movies in
            
            if movies != nil {
                self.moviesList.removeAll()
                self.moviesList += movies!
                self.tableView.reloadData()
                self.dismiss(animated: false, completion: nil)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesList.count
    }
    
   
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as! MovieTableCell
        let movie = moviesList[indexPath.row] as Movie
        cell.movieNameLabel.text    = movie.movieName
        cell.movieYearLabel.text    = String(describing: movie.movieYear)
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let destination: DetailsViewController = mainStoryboard.instantiateViewController(withIdentifier: "movieDetails") as! DetailsViewController
        destination.movie = self.moviesList[indexPath.row]
        navigationController?.pushViewController(destination, animated: true)
 
    }
    
    /*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destination:DetailsViewController = segue.destination as! DetailsViewController
        destination.movie = self.moviesList[(indexPath?.row)!]
        
    }
    */
}





















