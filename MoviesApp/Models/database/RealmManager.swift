//
//  RealmManager.swift
//  MoviesApp
//
//  Created by Mostafa AbdEl Fatah on 10/12/18.
//  Copyright © 2018 Mostafa AbdEl Fatah. All rights reserved.
//

import Foundation
import RealmSwift

class RealmManager{
    private let  realm = try! Realm()
    
    
    func getMovies() -> [Movie] {
        let result = realm.objects(Movie.self)
        var list = [Movie]()
        result.forEach { (movie) in
            list.append(movie)
        }
        return list
    }
    func getMovie(movie:Movie) -> Bool {
        let result = realm.objects(Movie.self);
        if result.count > 0 && result.filter("movieName == '\(String(describing: movie.movieName))'").first != nil {
            return true
            
        }
        return false
    }
    func add(movie:Movie) {
        try! realm.write {
            realm.add(movie)
        }
    }
    
    func remove(movie:Movie) {
        let result = realm.objects(Movie.self);
        if result.count > 0, let movieResult = result.filter("movieName == '\(String(describing: movie.movieName))'").first{
            try! realm.write {
                realm.delete(movieResult)
            }
        }
        /*if let movie = realm.objects(Movie.self).filter("movieName == \(String(describing: movie.movieName))").first {
            
            ////
        }*/
        ////
    }
    ////
    
}



