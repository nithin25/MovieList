//
//  ViewController.swift
//  MovieList
//
//  Created by Nithin Kumar on 01/02/2019.
//  Copyright © 2019 Nithin Kumar. All rights reserved.
//

import UIKit
import AFNetworking
import MBProgressHUD

class ViewController: UIViewController {

    @IBOutlet weak var pageControll: UIPageControl!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    
    var timer: Timer!
    var handler = MovieHandler()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.title = "Movie list"
        self.tableView.estimatedRowHeight = 100
        self.tableView.rowHeight = UITableView.automaticDimension
        
        self.getMoviesList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }

    func getMoviesList() {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        self.handler.fetchMovies { [weak self] (alertMessage) in
            if let message = alertMessage {
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
                    let alertAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
                    alert.addAction(alertAction)
                    self?.present(alert, animated: true, completion: nil)
                }
            } else {
                DispatchQueue.main.async {
                    self?.loadMovies()
                }
            }
        }
    }
    
    func loadMovies() {
        self.collectionView.reloadData()
        self.pageControll.numberOfPages = self.handler.featuredMoviesArray.count
        self.startTimer()
        self.tableView.reloadData()
        MBProgressHUD.hide(for: self.view, animated: true)
    }
    
    @objc func autoScrollCollectionView() {
        var currentPage = self.pageControll.currentPage + 1
        if currentPage >= self.pageControll.numberOfPages {
            currentPage = 0
        }
        
        let indexpath = IndexPath(item: currentPage, section: 0)
        self.collectionView.scrollToItem(at: indexpath, at: [.centeredHorizontally], animated: true)
        self.pageControll.currentPage = currentPage
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(autoScrollCollectionView), userInfo: nil, repeats: true)
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MovieDetailViewControllerFeaturedMovie" {
            let indexpath = self.collectionView.indexPath(for: (sender as! UICollectionViewCell))
            let viewController = segue.destination as! MovieDetailViewController
            viewController.movie = self.handler.featuredMoviesArray[indexpath!.row]
            viewController.handler = self.handler
        }
        else if segue.identifier == "MovieDetailViewControllerMovie" {
            let indexpath = self.tableView.indexPath(for: (sender as! UITableViewCell))
            let viewController = segue.destination as! MovieDetailViewController
            viewController.movie = self.handler.moviesArray[indexpath!.row]
            viewController.handler = self.handler
        }
    }
}


// MARK - Extension to handle UICollectionview callbacks
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.handler.featuredMoviesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeaturedMovieCell", for: indexPath) as! FeaturedMovieViewCell
        let movie = self.handler.featuredMoviesArray[indexPath.row]
        cell.setContents(withMovie: movie)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.size.width, height: collectionView.bounds.size.height)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        timer.invalidate()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        self.startTimer()
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pageControll.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.size.width)
    }
}

// MARK - Extension to handle UITableview callbacks
extension ViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.handler.moviesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell") as! MovieViewCell
        
        let movie = self.handler.moviesArray[indexPath.row]
        cell.setContents(withMovie: movie)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
