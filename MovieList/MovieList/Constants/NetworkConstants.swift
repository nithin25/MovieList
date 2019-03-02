//
//  NetworkConstants.swift
//  MovieList
//
//  Created by Nithin Kumar on 07/02/2019.
//  Copyright © 2019 Nithin Kumar. All rights reserved.
//

import Foundation

struct NetworkConstants {
    static let moviePosterBaseUrlString = "https://image.tmdb.org/t/p/w500"
    
    static func moviesUrl() -> URL? {
        let urlString = "https://api.themoviedb.org/3/movie/now_playing?api_key=" + ApiConstants.movieDBApiKey
        return URL(string: urlString)
    }
    
    static func movieVideoKeyUrl(withMovieId movieId: Int) -> URL? {
        let urlString = "https://api.themoviedb.org/3/movie/" + String(movieId) + "/videos?api_key=" + ApiConstants.movieDBApiKey
        return URL(string: urlString)
    }
    
    static func movieTrailerUrl(withVideoKey key: String) -> URL?{
        let urlString = "https://www.youtube.com/embed/" + key + "?modestbranding=1&showinfo=0"
        return URL(string: urlString)
    }
}
