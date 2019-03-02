//
//  MovieViewCell.swift
//  MovieList
//
//  Created by Nithin Kumar on 01/02/2019.
//  Copyright © 2019 Nithin Kumar. All rights reserved.
//

import UIKit

class MovieViewCell: UITableViewCell {

    @IBOutlet weak var nameLable: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var movieImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    /**
     Set cell conents using movie object
     
     - Parameter movie: **Movie** object
     */
    func setContents(withMovie movie: Movie) {
        if let url = movie.posterImageUrl {
            let urlRequest = URLRequest(url: url)
            self.movieImageView.setImageWith(
                urlRequest,
                placeholderImage: nil,
                success: { (request, response, image) in
                    self.movieImageView.image = image
            },
                failure: { (request, response, error) in
                    print("Something went wrong while downloading image:")
                    print(request.url ?? "")
                    print(error)
            })
        }
        
        self.nameLable.text = movie.movieTitle
        self.languageLabel.text = movie.language
    }

}
