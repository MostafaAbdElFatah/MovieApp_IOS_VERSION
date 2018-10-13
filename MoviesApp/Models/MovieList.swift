//
//  MovieList.swift
//  MoviesApp
//
//  Created by Mostafa AbdEl Fatah on 10/12/18.
//  Copyright © 2018 Mostafa AbdEl Fatah. All rights reserved.
//

import Foundation
import RealmSwift

class MovieList: Codable {
    var movieList:[Movie] = []
    enum CodingKeys: String, CodingKey{
        case movieList = "movies"
    }
}
class Movie: Object, Codable {
    @objc dynamic var movieName:String = ""
    @objc dynamic var movieYear:Int = 0
    @objc dynamic var movieRating:Float = 0.0
    @objc dynamic var movieDuration:String = ""
    @objc dynamic var movieDirector:String = ""
    @objc dynamic var movieTagline:String = ""
    var movieCast:[Cast] = []
    @objc dynamic var movieImage:String = ""
    @objc dynamic var movieStory:String = ""
    @objc dynamic var movieTralier:String = ""
    
    override static func primaryKey() -> String? {
        return "movieName"
    }
    
    enum CodingKeys: String, CodingKey{
        case movieName = "movie"
        case movieYear = "year"
        case movieRating  = "rating"
        case movieDirector = "director"
        case movieTagline = "tagline"
        case movieCast = "cast"
        case movieImage = "image"
        case movieStory  = "story"
    }

}
class Cast: Object, Codable{
    @objc dynamic var name:String = ""
}

/*
class MovieList: Codable {
    var movieList:[Movie] = []
    
    class Movie: Codable {
        
        var movieName:String?
        var movieYear:Int = 0
        var movieRating:Float?
        var movieDuration:String?
        var movieDirector:String?
        var movieTagline:String?
        var movieCast:[Cast] = []
        var movieImage:String?
        var movieStory:String?
        var movieTralier:String?
        
        class Cast: Codable{
            var name:String = ""
        }
    }
    enum CodingKeys: String, CodingKey
    {
        case movieList = "movies"
        case movieName = "movie"
        case movieYear = "year"
        case movieRating  = "rating"
        case MovieDirector = "director"
        case movieTagline = "tagline"
        case movieCast = "cast"
        case movieImage = "image"
        case movieStory  = "story"
    }
}*/
