//
//  MovieDetailViewController.swift
//  MovieList
//
//  Created by Nithin Kumar on 01/02/2019.
//  Copyright © 2019 Nithin Kumar. All rights reserved.
//

import UIKit
import WebKit
import MBProgressHUD

class MovieDetailViewController: UIViewController {
    
    struct DisplayConstants {
        static let screenWidthOffset: CGFloat = 20.0
    }
    
    var handler: MovieHandler!
    

    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var titleTable: UILabel!
    @IBOutlet weak var releaseDateLangLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var videoView: WKWebView!
    @IBOutlet weak var heightConstraintOverviewLabel: NSLayoutConstraint!
    
    
    var movie: Movie!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.titleTable.text = self.movie.movieTitle
        self.releaseDateLangLabel.text = self.movie.releaseDate + " - " + self.movie.language
        self.ratingLabel.text = "Rating: " + self.movie.rating
        self.overviewLabel.text = self.movie.overview
        self.setHeightForOverview()
        print(self.movie.overview)
        self.loadImageAndVideo()
        
        MBProgressHUD.showAdded(to: self.view, animated: true)
    }
    
    func setHeightForOverview() {
        let screenWidth = UIScreen.main.bounds.size.width
        let availableWidth = screenWidth - DisplayConstants.screenWidthOffset
        let overviewSize = self.overviewLabel.sizeThatFits(CGSize(width: availableWidth, height: CGFloat.greatestFiniteMagnitude))
        
        heightConstraintOverviewLabel.constant = overviewSize.height
    }
    
    func loadImageAndVideo() {
        if let url = self.movie.posterImageUrl{
            self.movieImageView.setImageWith(url)
        }
        
        self.handler.fetchVideoKey(forMovie: movie) { [weak self] (key) in
            guard let videoKey = key else {
                DispatchQueue.main.async {
                    self?.hideProgessHUD()
                }
                return
            }
            
            DispatchQueue.main.async {
                self?.loadYoutube(key: videoKey)
            }
        }
    }
    
    func loadYoutube(key: String) {
        self.hideProgessHUD()
        guard
            let videoURL = NetworkConstants.movieTrailerUrl(withVideoKey: key)
            else { return }
        videoView.load( URLRequest(url: videoURL) )
    }
    
    func hideProgessHUD() {
        MBProgressHUD.hide(for: self.view, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = false
    }
}
