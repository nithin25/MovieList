//
//  MovieHandler.swift
//  MovieList
//
//  Created by Nithin Kumar on 01/02/2019.
//  Copyright © 2019 Nithin Kumar. All rights reserved.
//

import UIKit

class MovieHandler: NSObject {
    
    var moviesArray = Array<Movie>()
    var featuredMoviesArray = Array<Movie>()
    
    /**
     Fetches all moview.
     If fetched successfully, it createe the movie models and returns nothing.
     If fetching failed, it returns `alert message` with error description.
     */
    func fetchMovies(_ completionHandler: @escaping ((_ alertMessage: String?) -> Void)) {
        let movieUrl = NetworkConstants.moviesUrl()
        
        if let url = movieUrl {
            NetworkManager().makeDataRequest(withUrl: url, requestSuccess: { [weak self] (movieList) in
                self?.createDataModel(movieList, completionHandler)
            }) { (error) in
                switch error {
                    
                case .apiResponseError(_):
                    completionHandler( error.localizedDescription)
                    print("error code: \((error as NSError).code)")
                case .invalidJson:
                    completionHandler("Invalid data recieved from server!")
                case .dataNotReceived:
                    completionHandler("Data not recieved from server!")
                }
            }
        } else {
            completionHandler("Invalid url!")
        }
    }
    
    /**
     Creates Movie models from the fetched movie collections.
     
     - Parameter list: list of items fetched
     */
    func createDataModel(_ list: Any?, _ completionHandler: @escaping ((_ alertMessage: String?) -> Void)) {
        //print(list)
        if  let response = list as? Dictionary<String, Any>,
            let result = response["results"] as? Array<Dictionary<String, Any>> {
            //print("result@@@@@@: \(result)")
            for item in result {
                //print(item)
                let movie = Movie(dictionary: item)
                
                if featuredMoviesArray.count < 5 {
                    featuredMoviesArray.append(movie)
                } else {
                    moviesArray.append(movie)
                }
            }
        }
        completionHandler(nil)
    }
    
    /**
     Fetches the video key for Movie trailer.
     
     - Parameter movie: **Movie** object
     
     - returns: the parsed **video key** in completion handler on success **OR** returns **nil** if request `failed`..
     */
    func fetchVideoKey(forMovie movie: Movie, completionHandler: @escaping ((String?) -> Void)) {
        if let movieId = movie.movieId,
            let videoUrl = NetworkConstants.movieVideoKeyUrl(withMovieId: movieId){
            NetworkManager().makeDataRequest(withUrl: videoUrl, requestSuccess: { (videoResponse) in
                if let responseDict = videoResponse as? NSDictionary {
                    let results = responseDict["results"] as! [NSDictionary]
                    let video = results[0]
                    let videoKey = video["key"] as? String
                    completionHandler(videoKey)
                }
            }) { (error) in
                print(error.localizedDescription)
                print("error code: \((error as NSError).code)")
                completionHandler(nil)
            }
        }
    }
}
