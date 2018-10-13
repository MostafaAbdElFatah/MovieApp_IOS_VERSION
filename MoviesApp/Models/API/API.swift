//
//  API.swift
//  MoviesApp
//
//  Created by Mostafa AbdEl Fatah on 10/11/18.
//  Copyright © 2018 Mostafa AbdEl Fatah. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class API: NSObject {
    
    class func fetchMovies(completion:@escaping (_ movies:[Movie]?)-> Void){
        
        Alamofire.request(URLs.main_url).responseJSON { (respone) in
            switch respone.result {
            case .failure(let error):
                print(error.localizedDescription)
                completion(nil)
            case .success(let value):
                //print(value)
                //let list = jsonPasing(value: value)
                let list:MovieList = jsonPasing(data: respone.data!)
                completion(list.movieList)
            }
        }
    }
    
    class func downloadImage( image:String, completion:@escaping (_ data:Data?)-> Void){

        Alamofire.request(image).responseData { (respone) in
            //completion(respone.data)
            switch respone.result {
            case .failure(let error):
                print(error)
                completion(nil)
            case .success(let value):
                //print(value)
                completion(value)
            }
        }
    }
    class func jsonPasing(data:Data)-> MovieList {
        let moviesList:MovieList? = try? JSONDecoder().decode(MovieList.self, from:data )
        if let list = moviesList?.movieList {
            for index in 0 ..< list.count {
                list[index].movieTralier = URLs.youtubeTraliers[index]
            }
            return moviesList!
        }
        return MovieList()
    }
    
    class func jsonPasing(value:Any)->[Movie]{
        var moviesList:[Movie] = []
        let json = JSON(value)
        //print(json["movies"])
        let movies = json["movies"].array
        
        for item in movies! {
            let movie = Movie()
            movie.movieName = item["movie"].string ?? "movie"
            movie.movieYear = item["year"].int ?? 2013
            movie.movieRating = item["rating"].float ?? 0.0
            movie.movieDuration = item["duration"].string ?? "duration"
            movie.movieDirector = item["director"].string ?? "director"
            movie.movieTagline = item["tagline"].string ?? "tagline"
            movie.movieImage = item["image"].string ?? "image"
            movie.movieStory = item["story"].string ?? "story"
            let casts = item["cast"].array
            for castJSON in casts! {
                let cast = Cast()
                cast.name = castJSON["name"].string ?? "name"
                movie.movieCast.append(cast)
            }
            
            moviesList.append(movie)
        }
        
        for index in 0 ..< moviesList.count {
            moviesList[index].movieTralier = URLs.youtubeTraliers[index]
        }

        return moviesList
    }
 
}






















