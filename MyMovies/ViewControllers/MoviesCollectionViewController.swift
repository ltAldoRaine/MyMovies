//
//  MoviesCollectionViewController.swift
//  MyMovies
//
//  Created by Beka Gelashvili on 12/19/20.
//

import UIKit
import PromiseKit

class MoviesCollectionViewFlowLayout: UICollectionViewFlowLayout {

    override func prepare() {
        super.prepare()
        guard let collectionView = collectionView else { return }
        let wSpace: CGFloat = minimumInteritemSpacing + sectionInset.left + sectionInset.right
        let hSpace: CGFloat = minimumLineSpacing + sectionInset.top + sectionInset.bottom
        let width = (collectionView.frame.width - wSpace) / 2.0
        let height = (collectionView.frame.height - hSpace) / 3.0
        itemSize = CGSize(width: width, height: height)
    }

}

class MoviesCollectionViewController: UICollectionViewController {

    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!

    private var movies = [MovieViewModel]()
    private var movieType: MovieType = .upcoming
    private var promises = [(promise: Promise<[MovieViewModel]>, movieType: MovieType)]()

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(MovieCollectionViewCell.nib, forCellWithReuseIdentifier: MovieCollectionViewCell.description)
        promises = [
            (promise: MovieViewModel.popular(), movieType: .popular),
            (promise: MovieViewModel.upcoming(), movieType: .upcoming),
            (promise: MovieViewModel.topRated(), movieType: .topRated),
            (promise: MovieViewModel.favorite(), movieType: .favorite)
        ]
        getMovies()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination
        switch destination {
        case is MovieViewController:
            let movieViewController = destination as! MovieViewController
            movieViewController.movieViewModel = sender as? MovieViewModel
        default:
            return
        }
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.description, for: indexPath) as! MovieCollectionViewCell
        let movie = movies[indexPath.row]
        if let posterPath = movie.posterPath, let url = URL(string: Network.moviePoster(posterPath)) {
            cell.posterImageView.kf.setImage(with: url)
        }
        cell.titleLabel.text = movie.title
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = movies[indexPath.row]
        performSegue(withIdentifier: "MovieViewControllerSegue", sender: movie)
    }

    @IBAction func onPopularBarButtonItemTapped() {
        movieType = .popular
        title = movieType.description
        getMovies()
    }

    @IBAction func onUpcomingBarButtonItemTapped() {
        movieType = .upcoming
        title = movieType.description
        getMovies()
    }

    @IBAction func onTopRatedBarButtonItemTapped() {
        movieType = .topRated
        title = movieType.description
        getMovies()
    }

    @IBAction func onFavoriteBarButtonItemTapped() {
        movieType = .favorite
        title = movieType.description
        getMovies()
    }

    private func getMovies() {
        activityIndicatorView.startAnimating()
        promises.first { $0.movieType == movieType }?.promise
            .done { data -> Void in
                self.activityIndicatorView.stopAnimating()
                self.movies = data
                self.collectionView.reloadData()
            }
            .catch { error in print(error.localizedDescription) }
    }

}
