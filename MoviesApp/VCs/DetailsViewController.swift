import UIKit
import youtube_ios_player_helper

class DetailsViewController: UIViewController {

    
    var movie:Movie = Movie()
    var isFavorite:Bool = false
    let realmManager = RealmManager()
    
    @IBOutlet weak var youtubeTrailer: YTPlayerView!
    @IBOutlet weak var movieTaglineLabel: UILabel!
    @IBOutlet weak var movieYearLabel: UILabel!
    @IBOutlet weak var movieDurationLLabel: UILabel!
    @IBOutlet weak var movieDirectorLabel: UILabel!
    @IBOutlet weak var movieCastLabel: UILabel!
    @IBOutlet weak var MovieStoryLabel: UILabel!
    @IBOutlet weak var favoriteBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = movie.movieName
        movieTaglineLabel.text = movie.movieTagline
        movieYearLabel.text = String(describing: movie.movieYear)
        movieDurationLLabel.text = movie.movieDuration
        movieDirectorLabel.text = movie.movieDirector
        MovieStoryLabel.text = movie.movieStory
     
        var cast:String = ""
        for castObj in movie.movieCast{
            cast += ", \(String(describing: castObj.name))"
        }
        cast.removeFirst()
        cast.removeFirst()
        movieCastLabel.text = cast
        if realmManager.getMovie(movie: self.movie) {
            self.isFavorite = true
            let image = UIImage(named: "heart")
            favoriteBtn.setImage(image, for: UIControlState.normal)
        }else{
            self.isFavorite = false
            let image = UIImage(named: "borderheart")
            favoriteBtn.setImage(image, for: UIControlState.normal)
        }
        //youtubeTrailer.load(withVideoId: movie.movieTralier!)
        youtubeTrailer.load(withVideoId: movie.movieTralier, playerVars: ["playsinline":NSNumber.init(value: 1)])
        youtubeTrailer.playVideo()
    }
    
    
    @IBAction func favoritebtnClicked(_ sender: UIButton) {
        
        var message = ""
        if !realmManager.getMovie(movie: self.movie) {
            message = "Movie Added Successfully to favorite list"
            let image = UIImage(named: "heart")
            sender.setImage(image, for: UIControlState.normal)
            realmManager.add(movie: self.movie)
        }else {
            message = "Movie removed Successfully from favorite list"
            let image = UIImage(named: "borderheart")
            sender.setImage(image, for: UIControlState.normal)
            realmManager.remove(movie: self.movie)
        }
        /*
        let alert = UIAlertController(title: "Movie App", message:message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: { (alert) in
            self.dismiss(animated: true , completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)*/
    }
    
}
















