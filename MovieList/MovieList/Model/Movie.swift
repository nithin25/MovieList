//
//  Movie.swift
//  MovieList
//
//  Created by Nithin Kumar on 01/02/2019.
//  Copyright © 2019 Nithin Kumar. All rights reserved.
//

import Foundation

class Movie: NSObject {
    var posterImageUrl: URL?
    var releaseDate: String = "-"
    var language : String = "-"
    var title: String = ""
    var overview: String = ""
    var movieTitle: String = ""
    var rating: String = ""
    var movieId: Int?
    
    init(dictionary: Dictionary<String, Any>) {
        let baseString = NetworkConstants.moviePosterBaseUrlString
        if let posterPath = dictionary["poster_path"] as? String{
            let imageUrlString = baseString + posterPath
            self.posterImageUrl = URL(string: imageUrlString)
        }
        
        if let releaseDate = dictionary["release_date"] as? String {
            self.releaseDate = releaseDate
        }
        
        if let languageCode = dictionary["original_language"] as? String {
            let locale = NSLocale.autoupdatingCurrent
            if let language = locale.localizedString(forLanguageCode: languageCode) {
                self.language = language
            }
        }
        
        if let title = dictionary ["original_title"] as? String {
            self.movieTitle = title
        }
        
        if let overview = dictionary["overview"] as? String {
            self.overview = overview
        }
        
        if let rating = dictionary["vote_average"] as? Double {
            self.rating = String(format: "%.1f", rating)
        }
        
        if let movieId = dictionary["id"] as? Int {
            self.movieId = movieId
        }
    }
}
