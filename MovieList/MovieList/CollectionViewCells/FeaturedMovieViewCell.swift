//
//  FeaturedMovieViewCell.swift
//  MovieList
//
//  Created by Nithin Kumar on 01/02/2019.
//  Copyright © 2019 Nithin Kumar. All rights reserved.
//

import UIKit

class FeaturedMovieViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    /**
     Set cell conents using movie object
     
     - Parameter movie: **Movie** object
     */
    func setContents(withMovie movie: Movie) {
        if let url = movie.posterImageUrl {
            let urlRequest = URLRequest(url: url)
            self.imageView.setImageWith(
                urlRequest,
                placeholderImage: nil,
                success: { (request, response, image) in
                    self.imageView.image = image
            },
                failure: { (request, response, error) in
                    print("Something went wrong while downloading image:")
                    print(request.url ?? "")
                    print(error)
            })
        }
    }
}
