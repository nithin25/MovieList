//
//  MovieListHandlerTests.swift
//  MovieListTests
//
//  Created by Nithin Kumar on 02/02/2019.
//  Copyright © 2019 Nithin Kumar. All rights reserved.
//

import XCTest
@testable import MovieList

class MovieListHandlerTests: XCTestCase {

    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    func testCreateModelForValidObject() {
        let list = ["date":["maximum":"2019-02-07", "minimum":"2018-12-21"], "page":1, "results":[["adult":0, "backdrop_path":"/lvjscO8wmpEbIfOEZi92Je8Ktlg.jpg","genre_ids":[53, 9648, 18], "id":450465,"original_language":"en", "original_title":"Glass", "overview":"In a series of escalating encounters, security guard David Dunn uses his supernatural abilities to track Kevin Wendell Crumb, a disturbed man who has twenty-four personalities. Meanwhile, the shadowy presence of Elijah Price emerges as an orchestrator who holds secrets critical to both men.", "popularity":"360.395", "poster_path":"/gt5KPtwDMeIOPdVfmjYlFw9EetE.jpg", "release_date":"2019-01-16", "title":"Glass","video":0, "vote_average":"6.9", "vote_count":959], ["adult":0, "backdrop_path":"/lvjscO8wmpEbIfOEZi92Je8Ktlg.jpg","genre_ids":[53, 9648, 18], "id":450465,"original_language":"en", "original_title":"Glass", "overview":"In a series of escalating encounters, security guard David Dunn uses his supernatural abilities to track Kevin Wendell Crumb, a disturbed man who has twenty-four personalities. Meanwhile, the shadowy presence of Elijah Price emerges as an orchestrator who holds secrets critical to both men.", "popularity":"360.395", "poster_path":"/gt5KPtwDMeIOPdVfmjYlFw9EetE.jpg", "release_date":"2019-01-16", "title":"Glass","video":0, "vote_average":"6.9", "vote_count":959], ["adult":0, "backdrop_path":"/lvjscO8wmpEbIfOEZi92Je8Ktlg.jpg","genre_ids":[53, 9648, 18], "id":450465,"original_language":"en", "original_title":"Glass", "overview":"In a series of escalating encounters, security guard David Dunn uses his supernatural abilities to track Kevin Wendell Crumb, a disturbed man who has twenty-four personalities. Meanwhile, the shadowy presence of Elijah Price emerges as an orchestrator who holds secrets critical to both men.", "popularity":"360.395", "poster_path":"/gt5KPtwDMeIOPdVfmjYlFw9EetE.jpg", "release_date":"2019-01-16", "title":"Glass","video":0, "vote_average":"6.9", "vote_count":959], ["adult":0, "backdrop_path":"/lvjscO8wmpEbIfOEZi92Je8Ktlg.jpg","genre_ids":[53, 9648, 18], "id":450465,"original_language":"en", "original_title":"Glass", "overview":"In a series of escalating encounters, security guard David Dunn uses his supernatural abilities to track Kevin Wendell Crumb, a disturbed man who has twenty-four personalities. Meanwhile, the shadowy presence of Elijah Price emerges as an orchestrator who holds secrets critical to both men.", "popularity":"360.395", "poster_path":"/gt5KPtwDMeIOPdVfmjYlFw9EetE.jpg", "release_date":"2019-01-16", "title":"Glass","video":0, "vote_average":"6.9", "vote_count":959], ["adult":0, "backdrop_path":"/lvjscO8wmpEbIfOEZi92Je8Ktlg.jpg","genre_ids":[53, 9648, 18], "id":450465,"original_language":"en", "original_title":"Glass", "overview":"In a series of escalating encounters, security guard David Dunn uses his supernatural abilities to track Kevin Wendell Crumb, a disturbed man who has twenty-four personalities. Meanwhile, the shadowy presence of Elijah Price emerges as an orchestrator who holds secrets critical to both men.", "popularity":"360.395", "poster_path":"/gt5KPtwDMeIOPdVfmjYlFw9EetE.jpg", "release_date":"2019-01-16", "title":"Glass","video":0, "vote_average":"6.9", "vote_count":959], ["adult":0, "backdrop_path":"/lvjscO8wmpEbIfOEZi92Je8Ktlg.jpg","genre_ids":[53, 9648, 18], "id":450465,"original_language":"en", "original_title":"Glass", "overview":"In a series of escalating encounters, security guard David Dunn uses his supernatural abilities to track Kevin Wendell Crumb, a disturbed man who has twenty-four personalities. Meanwhile, the shadowy presence of Elijah Price emerges as an orchestrator who holds secrets critical to both men.", "popularity":"360.395", "poster_path":"/gt5KPtwDMeIOPdVfmjYlFw9EetE.jpg", "release_date":"2019-01-16", "title":"Glass","video":0, "vote_average":"6.9", "vote_count":959]], "total_pages":44, "total_results":867] as [String : Any]
        let handler = MovieHandler()
        handler.createDataModel(list) { (message) in
        }
        XCTAssertNotEqual(handler.featuredMoviesArray.count, 0)
        XCTAssertNotEqual(handler.moviesArray.count, 0)
    }
    
    func testEmptyObject() {
        let list = [String: Any]()
        let handler = MovieHandler()
        handler.createDataModel(list) { (message) in
        }

        XCTAssertEqual(handler.featuredMoviesArray.count, 0)
        XCTAssertEqual(handler.moviesArray.count, 0)
    }

    func testCreateModelForInvalidObject() {
        let list = ["$randomKey": "$randomValue"]
        let handler = MovieHandler()
        handler.createDataModel(list) { (message) in

        }

        XCTAssertEqual(handler.featuredMoviesArray.count, 0)
        XCTAssertEqual(handler.moviesArray.count, 0)
    }
}
